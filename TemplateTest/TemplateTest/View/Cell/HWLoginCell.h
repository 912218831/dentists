//
//  HWLoginCell.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWLoginCell : HWBaseTableViewCell

@property(strong,nonatomic)void(^textChange)(NSString * text);
@property(strong,nonatomic)UITextField * tf;
- (void)configCellWithPlaceHolder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType limitNumber:(NSInteger)limitNumber;

@end
