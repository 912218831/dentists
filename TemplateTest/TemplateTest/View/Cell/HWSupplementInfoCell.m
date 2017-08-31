//
//  HWSupplementInfoCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWSupplementInfoCell.h"
#import "UITextField+Utils.h"

@interface HWSupplementInfoCell()<UITextFieldDelegate>

@property(assign,nonatomic)NSInteger limitNum;

@end

@implementation HWSupplementInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.tf];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.tf];
        CALayer * line = [[CALayer alloc] init];
        line.frame = CGRectMake(kRate(47), kRate(60)-0.5, kScreenWidth - kRate(47)*2, 0.5);
        line.backgroundColor = COLOR_DEDEDE.CGColor;
        [self.contentView.layer addSublayer:line];

    }
    return self;
}

- (UITextField *)tf
{
    if (_tf == nil) {
        _tf = [[UITextField alloc] initWithFrame:CGRectMake(kRate(54), 0, kScreenWidth - kRate(54)*2, kRate(60)-0.5)];
        _tf.delegate = self;
        _tf.keyboardType = UIKeyboardTypePhonePad;
        _tf.textAlignment = NSTextAlignmentLeft;
        _tf.font = FONT(16.0f);
        _tf.textColor = COLOR_333333;
        _tf.placeholder = @"请输入手机号";
    }
    return _tf;
}

- (void)configPlaceHolder:(NSString *)placeHolder content:(NSString *)content limitNum:(NSInteger)limitNum inputEnable:(BOOL)inputEnable
{
    self.tf.placeholder = placeHolder;
    self.tf.text = content;
    self.limitNum = limitNum;
    self.tf.enabled = inputEnable;
}
#pragma textFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textEndChange) {
        self.textEndChange(textField.text);
    }
}

- (void)textChange:(NSNotification *)notify
{
    if (self.limitNum) {
        [self.tf textLimitInputNumber:self.limitNum];
    }
    
    if (self.textEndChange) {
        self.textEndChange(self.tf.text);
    }
    
}

+ (float)getCellHeight
{
    return kRate(60);
}

@end
