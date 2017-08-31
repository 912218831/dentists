//
//  HWUserLogin.h
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HWUserLogin : NSObject

@property(strong,nonatomic)NSString * username;
@property(strong,nonatomic)NSString * usertype;
@property(strong,nonatomic)NSString * userkey;

+ (HWUserLogin *)currentUserLogin;

-(void)loadData;

// 注销
- (void)userLogout;



@end
