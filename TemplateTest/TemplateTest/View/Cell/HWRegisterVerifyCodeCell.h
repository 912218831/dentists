//
//  HWRegisterVerifyCodeCell.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWRegisterViewController.h"
@interface HWRegisterVerifyCodeCell : HWBaseTableViewCell
@property(strong,nonatomic)NSString * telphoneNum;//电话号码
@property(strong,nonatomic)NSString * sms_type;//验证码类型
@property(strong,nonatomic)void(^textChange)(NSString * VerifyCode);
- (void)configCellWithVerifyCode:(NSString *)VerifyCode;

@end
