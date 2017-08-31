//
//  HWLoginCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWLoginCell.h"

@interface HWLoginCell()<UITextFieldDelegate>
@property(assign,nonatomic)NSInteger  limitNumber;
@end

@implementation HWLoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.tf];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.tf];
    }
    return self;
}

- (UITextField *)tf
{
    if (_tf == nil) {
        _tf = [[UITextField alloc] initWithFrame:CGRectMake(kRate(47), 0, kScreenWidth - kRate(47)*2, kRate(60))];
        _tf.font = FONT(16.0f);
        _tf.textAlignment = NSTextAlignmentCenter;
        _tf.textColor = COLOR_999999;
        _tf.delegate = self;
        [_tf drawBottomLine];
    }
    return _tf;
}

- (void)configCellWithPlaceHolder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType limitNumber:(NSInteger)limitNumber
{
    self.tf.placeholder = placeholder;
    self.tf.keyboardType = keyboardType;
    self.limitNumber = limitNumber;
}

#pragma UITextFieldDelegate

- (void)textChange:(NSNotification *)notify
{
    NSString * str = self.tf.text;
    if (str.length > self.limitNumber) {
        self.tf.text = [str substringToIndex:self.limitNumber];
    }
    if (self.textChange) {
        self.textChange(self.tf.text);
    }
}


+(float)getCellHeight
{
    return kRate(60);
}

- (void)dealloc
{
    NSLog(@"%@",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
