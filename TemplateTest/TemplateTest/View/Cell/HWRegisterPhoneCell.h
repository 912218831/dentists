//
//  HWRegisterPhoneCell.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWRegisterPhoneCell : HWBaseTableViewCell

@property(strong,nonatomic)void(^textChange)(NSString * phoneNumber);

- (void)configCellWithPhoneNumber:(NSString *)phoneNumber;
@end
