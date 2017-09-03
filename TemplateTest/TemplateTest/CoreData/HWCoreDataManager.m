//
//  HWCoreDataManager.m
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCoreDataManager.h"
#import "AppDelegate.h"
#import  "HWLoginUser+CoreDataProperties.h"

@implementation HWCoreDataManager


#pragma mark - user

+ (void)saveUserInfo
{
    HWUserLogin *userLogin = [HWUserLogin currentUserLogin];
    
    HWLoginUser * user = [HWLoginUser MR_createEntity];
    user.key = userLogin.userkey;
    user.userName = userLogin.username;
    user.userPhone = userLogin.userPhone;
    user.userType = userLogin.usertype;
    user.userPassword = userLogin.userPassword;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

+ (void)loadUserInfo
{
    [[HWUserLogin currentUserLogin]loadData];
}

+ (void)clearUserInfo
{
    [HWCoreDataManager deleteAllData:@"HWLoginUser"];
}


+ (void)deleteAllData:(NSString *)tableName
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:tableName];
    NSError *error = nil;
    NSArray *fetchedObjects = [[NSManagedObjectContext MR_defaultContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil)
    {
        for (NSManagedObject * obj in fetchedObjects) {
            
            [[NSManagedObjectContext MR_defaultContext] deleteObject:obj];
        }
        
       [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else
    {
        NSLog(@" error:%@",error.localizedDescription);
    }
    
}

@end
