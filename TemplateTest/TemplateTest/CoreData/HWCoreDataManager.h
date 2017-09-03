//
//  HWCoreDataManager.h
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HWCoreDataManager : NSObject

@property (nonatomic,strong) NSFetchedResultsController * fetchResultsController;
@property (nonatomic,strong) NSManagedObjectContext * managerObjectContext;

+ (void)saveUserInfo;
+ (void)loadUserInfo;
+ (void)clearUserInfo;

@end
