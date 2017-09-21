//
//  HWUserLogin.m
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWUserLogin.h"
#import <YYModel/YYModel.h>
#import "HWLoginUser+CoreDataProperties.h"
@implementation HWUserLogin

static HWUserLogin *userLogin = nil;




+ (HWUserLogin *)currentUserLogin
{
    static dispatch_once_t onceToken;
    static HWUserLogin *userLogin = nil;
    dispatch_once(&onceToken, ^{
            userLogin = [[HWUserLogin alloc] init];
    });
    
    return userLogin;
}

- (BOOL)yy_modelSetWithDictionary:(NSDictionary *)dic
{
    HWLoginUser * loginUser;
    if ([HWLoginUser MR_findAll].count > 0) {
        loginUser = [HWLoginUser MR_findFirst];

    }
    else
    {
        loginUser = [HWLoginUser MR_createEntity];
    }
    loginUser.userName = [dic stringObjectForKey:@"username"];
    loginUser.userPhone = [dic stringObjectForKey:@""];
    loginUser.userType = [dic stringObjectForKey:@"usertype"];
    loginUser.key = [dic stringObjectForKey:@"userkey"];
    loginUser.userPassword = [dic stringObjectForKey:@"userPassword"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    });

    return [super yy_modelSetWithDictionary:dic];
}

- (void)userLogout
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [HWLoginUser MR_truncateAll];
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    });

    self.usertype = @"";
    self.username = @"";
    self.userkey = @"";
    self.userPassword = @"";
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    });
}

-(void)loadData
{
    if ([[HWLoginUser MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]] count] > 0) {
        HWLoginUser * loginUser = [HWLoginUser MR_findFirst];
        self.username = loginUser.userName;
        self.userPhone = loginUser.userPhone;
        self.userkey = loginUser.key;
        self.usertype = loginUser.userType;
        self.userPassword = loginUser.userPassword;
        NSLog(@"userPhoneRead=%@",loginUser.userPhone);
    }
}



@end
