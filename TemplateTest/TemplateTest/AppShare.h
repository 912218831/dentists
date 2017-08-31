//
//  AppShare.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/28.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWLoginUser+CoreDataProperties.h"
#import "RDVTabBarController.h"
@interface AppShare : NSObject

+ (instancetype)shareInstance;

- (void)handelCurrentCoreDataLoginUser:(void(^)(HWLoginUser * loginUser))currentLoginUser;

- (RDVTabBarController *)checkUserType;

@end
