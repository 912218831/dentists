//
//  HWUserLogin.h
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HWUserLogin : NSObject

@property(copy, nonatomic)NSString * username;
@property(copy, nonatomic)NSString * userPhone;
@property(copy, nonatomic)NSString * usertype;
@property(copy, nonatomic)NSString * userkey;
@property(copy, nonatomic)NSString * userPassword;
@property(copy, nonatomic)NSString * vertifyCode;
+ (HWUserLogin *)currentUserLogin;

-(void)loadData;

// 注销
- (void)userLogout;



@end
