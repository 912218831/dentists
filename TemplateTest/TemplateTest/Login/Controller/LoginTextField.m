//
//  LoginTextField.m
//  TemplateTest
//
//  Created by HW on 17/9/2.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "LoginTextField.h"

@interface LoginTextField ()
@property (nonatomic, strong, readwrite) UILabel *leftLabel;
@property (nonatomic, strong, readwrite) UITextField *textfield;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation LoginTextField

- (void)initSubViews {
    
    self.textfield = [UITextField new];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftLabel = [UILabel new];
    
    [self addSubview:self.textfield];
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightBtn];
}

- (void)layoutSubViews {
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRate(21));
        make.centerY.equalTo(self);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-kRate(21)).priority(MASLayoutPriorityRequired);
        make.centerY.equalTo(self);
        make.width.priority(MASLayoutPriorityRequired);
        make.left.equalTo(self.textfield.mas_right).with.offset(kRate(30));
    }];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.top.equalTo(self).with.offset(kRate(6));
        make.bottom.equalTo(self).with.offset(-kRate(6));
        make.left.equalTo(self.leftLabel.mas_right).with.offset(kRate(30));
    }];
}

- (void)initDefaultConfigs {
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = COLOR_FFFFFF.CGColor;
    
    self.leftLabel.text = @"";
    self.leftLabel.textColor = UIColorFromRGB(0xafe2ff);
    self.leftLabel.font = FONT(TF16);
    
    self.rightBtn.normalTitle = @"验证码";
    self.rightBtn.normalColor = COLOR_FFFFFF;
    self.rightBtn.normalFont = FONT(TF15);
    self.textfield.textColor = COLOR_FFFFFF;
    self.textfield.font = FONT(TF16);
    
    @weakify(self);
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *sender) {
        @strongify(self);
        if (self.rightChannel) {
            [self.rightChannel.leadingTerminal sendNext:sender];
        }
    }];
    
    [self.rightBtn sizeToFit];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.rightBtn.width).priority(MASLayoutPriorityRequired);
    }];
}

- (void)setRightChannel:(RACChannel *)rightChannel {
    _rightChannel = rightChannel;
    [_rightChannel.leadingTerminal subscribeNext:^(id x) {
        // 验证码倒计时
        NSLog(@"验证码倒计时");
    }];
}

- (void)setNeedRightBtn:(BOOL)needRightBtn {
    self.rightBtn.hidden = !needRightBtn;
}

@end
