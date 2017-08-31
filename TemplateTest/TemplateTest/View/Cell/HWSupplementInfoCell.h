//
//  HWSupplementInfoCell.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWSupplementInfoCell : HWBaseTableViewCell

@property(assign,nonatomic)BOOL inputEnable;//是否允许输入
@property(copy,nonatomic)void(^textEndChange)(NSString * text);
@property(strong,nonatomic)UITextField * tf;
- (void)configPlaceHolder:(NSString *)placeHolder content:(NSString *)content limitNum:(NSInteger)limitNum inputEnable:(BOOL)inputEnable;

@end
