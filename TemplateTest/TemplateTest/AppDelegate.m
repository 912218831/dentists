//
//  AppDelegate.m
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/4/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "AppDelegate.h"
#import "HWBaseNavigationController.h"
#import <UserNotifications/UserNotifications.h>
#import <AFNetworking/AFNetworking.h>
#import "HWHTTPSessionManger.h"
#import "HWLocationManager.h"
#import "HWTabBarViewController.h"
#import "HWLoginUser+CoreDataProperties.h"
#import "HWGuideViewController.h"
static NSString * kHaowuStoreName = @"TemplateTest1.sqlite";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
            
    [self copyDefaultStoreIfNecessary];
    
    [self registerAPNS];
    [JPUSHService setupWithOption:launchOptions appKey:@"74535d99ff5ace1330adce4d" channel:@"iOS" apsForProduction:NO];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kHaowuStoreName];
    [[HWUserLogin currentUserLogin] loadData];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    self.viewController = [[AppShare shareInstance] checkUserType];
    [self.window setRootViewController:self.viewController];
    self.isAutoLogin = YES;

//    if ([HWUserLogin currentUserLogin].userkey.length > 0) {
//        self.viewController = [[AppShare shareInstance] checkUserType];
//        [self.window setRootViewController:self.viewController];
//        self.isAutoLogin = YES;        
//    }
//    else
//    {
//        HWGuideViewController * guideCtrl = [[HWGuideViewController alloc] init];
//        guideCtrl.isGuide = NO;
//        [self.window setRootViewController:guideCtrl];
//        self.isAutoLogin = NO;
//
//    }
    
    
    return YES;
}


- (void)registerAPNS
{
    //注册APNs
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
 
    
}

- (void)startLocation
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    //定位
    __weak HWLocationManager * locationManger = [HWLocationManager shareManager];
    [locationManger startLocating];
    [locationManger setLocationSuccess:^(CLLocation * loc , NSString * cityName,NSString *streetName) {
        /**
         *  后台数据库没有城市没有"市"
         */
        [userDefault setObject:@"0" forKey:@"kLocationTime"];
        
        NSRange range = [cityName rangeOfString:@"市"];
        if (range.location != NSNotFound)
        {
            cityName = [cityName substringToIndex:range.location];
        }
        
        if (cityName.length > 4)
        {
            cityName = [cityName substringToIndex:4];
        }
        
        
        NSString *lastLocationCity = [userDefault objectForKey:@"kLastLocationCity"];
        if (lastLocationCity == nil)
        {
            [userDefault setObject:cityName forKey:@"kLastLocationCity"];
            [userDefault synchronize];
        }
        
    }];
    [locationManger setLocationFailed:^(BOOL isOpenLocator){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationFailNotification object:nil];
        
        NSString *lTime = [userDefault objectForKey:@"kLocationTime"];
        if (lTime.intValue < 5)
        {
            // 失败 3次以上 停止定位
            [locationManger startLocating];
            [userDefault setObject:[NSString stringWithFormat:@"%d", lTime.intValue + 1] forKey:@"kLocationTime"];
            [userDefault synchronize];
            
        }
        
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"Memory warning");
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDWebImageManager sharedManager] cancelAll];
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [NSManagedObjectContext MR_defaultContext];
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置

}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void) copyDefaultStoreIfNecessary;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:kHaowuStoreName];
    
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]])
    {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[kHaowuStoreName stringByDeletingPathExtension] ofType:[kHaowuStoreName pathExtension]];
        
        if (defaultStorePath)
        {
            NSError *error;
            BOOL success = [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL path] error:&error];
            if (!success)
            {
                NSLog(@"Failed to install default recipe store");
            }
        }
    }
    
}


@end
