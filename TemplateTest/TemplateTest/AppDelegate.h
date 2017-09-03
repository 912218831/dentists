//
//  AppDelegate.h
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/4/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HWCheckForceUpdateWidget.h"
#import <JPush/JPUSHService.h>
#import "HWTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HWTabBarViewController *tabBarVC;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) HWCheckForceUpdateWidget *updataWidget;
@property (strong,nonatomic)UIViewController * viewController;
@property(assign,nonatomic)BOOL isAutoLogin;

@end

