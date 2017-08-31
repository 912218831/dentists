//
//  HWRegisterVerifyCodeCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWRegisterVerifyCodeCell.h"

@interface HWRegisterVerifyCodeCell()<UITextFieldDelegate>

@property(nonatomic,strong)NSTimer * timer;
@property(strong,nonatomic)UIButton * verifyCodeBtn;
@property(strong,nonatomic)UITextField * tf;
@property(assign,nonatomic)NSInteger  count;

@end

@implementation HWRegisterVerifyCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.count = 10;
        [self.contentView addSubview:self.tf];
        [self.contentView addSubview:self.verifyCodeBtn];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.tf];
        CALayer * line = [[CALayer alloc] init];
        line.frame = CGRectMake(kRate(47), kRate(60)-0.5, kScreenWidth - kRate(47)*2, 0.5);
        line.backgroundColor = COLOR_DEDEDE.CGColor;
        [self.contentView.layer addSublayer:line];
    }
    return self;
}

- (UIButton *)verifyCodeBtn
{
    if (_verifyCodeBtn == nil) {
        _verifyCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.tf.right+10, 0, 103, kRate(60)-0.5)];
        [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyCodeBtn.titleLabel.font = FONT(15.0f);
        [_verifyCodeBtn setTitleColor:COLOR_21A754 forState:UIControlStateNormal];
        [_verifyCodeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateDisabled];
        [_verifyCodeBtn setBackgroundImage:[Utility imageWithColor:COLOR_FFFFFF andSize:CGSizeMake(93, kRate(60)-0.5)] forState:UIControlStateNormal];
        [_verifyCodeBtn setBackgroundImage:[Utility imageWithColor:[UIColor grayColor] andSize:CGSizeMake(93, kRate(60)-0.5)] forState:UIControlStateDisabled];
        [_verifyCodeBtn addTarget:self action:@selector(queryVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyCodeBtn;
}

- (UITextField *)tf
{
    if (_tf == nil) {
        _tf = [[UITextField alloc] initWithFrame:CGRectMake(kRate(54), 0, kScreenWidth - 103 - kRate(54)*2 - 10, kRate(60)-0.5)];
        _tf.textColor = COLOR_333333;
        _tf.delegate = self;
        _tf.textAlignment = NSTextAlignmentLeft;
        _tf.font = FONT(16.0f);
        _tf.keyboardType = UIKeyboardTypeNumberPad;
        _tf.placeholder = @"请输入验证码";
    }
    return _tf;
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

- (void)queryVerifyCode
{
    if (![Utility validateMobile:self.telphoneNum]) {
        [Utility showToastWithMessage:@"请输入正确的手机号"];
        return;
    }
    self.verifyCodeBtn.userInteractionEnabled = NO;
    self.verifyCodeBtn.enabled = NO;
    [self.timer fire];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setPObject:self.telphoneNum forKey:@"mobile"];
    [params setPObject:self.sms_type forKey:@"sms_type"];
    HWHTTPSessionManger * manager = [HWHTTPSessionManger manager];
    [manager HWPOST:kGetVerifyCode parameters:params success:^(id responese) {
        
        NSLog(@"%@",responese);
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error];
    }];
}
- (void)timerAction:(NSTimer *)timer
{
    self.count--;
    if (self.count == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.count = 10;
        [self.verifyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.verifyCodeBtn.userInteractionEnabled = YES;
        self.verifyCodeBtn.enabled = YES;

    }
    else
    {
        NSString * str = [NSString stringWithFormat:@"%lds",self.count];
        [self.verifyCodeBtn setTitle:str forState:UIControlStateDisabled];
    }
}


- (void)textChange:(NSNotification *)notify
{
    NSString * str = self.tf.text;
    if (str.length > 6) {
        self.tf.text = [str substringToIndex:11];
    }
    if (self.textChange) {
        self.textChange(self.tf.text);
    }
}

- (void)configCellWithVerifyCode:(NSString *)VerifyCode
{
    self.tf.text = VerifyCode;
}

+(float)getCellHeight
{
    return kRate(60);
}
@end
