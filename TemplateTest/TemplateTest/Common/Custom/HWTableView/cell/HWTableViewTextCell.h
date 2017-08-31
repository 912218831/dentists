//
//  HWTableViewTextCell.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewCell.h"
#import "HWTextItem.h"
@interface HWTableViewTextCell : HWTableViewCell<UITextFieldDelegate>

@property (nonatomic,strong) HWTextItem * item;

@property (nonatomic,strong) UITextField * textField;




@end
