//
//  AppShare.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/28.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "AppShare.h"
#import "HWTabBarViewController.h"
@implementation AppShare

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static AppShare * share = nil;
    dispatch_once(&onceToken, ^{
        share = [[AppShare alloc] init];
    });
    return share;
}

- (void)handelCurrentCoreDataLoginUser:(void (^)(HWLoginUser *))currentLoginUser
{
    HWLoginUser * loginUer;
    if ([HWLoginUser MR_findAll].count) {
         loginUer = [HWLoginUser MR_findFirst];
    }
    else
    {
         loginUer = [HWLoginUser MR_createEntity];
    }
    if (currentLoginUser) {
        currentLoginUser(loginUer);
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [[HWUserLogin currentUserLogin] loadData];
}

- (RDVTabBarController *)checkUserType
{
    HWTabBarViewController * ctrl = [[HWTabBarViewController alloc] init];
    //        SHARED_APP_DELEGATE.viewController = ctrl;
    return ctrl;
}
@end
