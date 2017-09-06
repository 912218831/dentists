//
//  HWLoginViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWLoginViewController.h"
#import "LoginViewModel.h"
#import "LoginTextField.h"

@interface HWLoginViewController ()
@property (nonatomic, strong) LoginViewModel *viewModel;
@property (nonatomic, strong) LoginTextField *usernameTextField;
@property (nonatomic, strong) LoginTextField *vertifyCodeTextField;
@property (nonatomic, strong) UIButton    *loginBtn;
@end

@implementation HWLoginViewController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configContentView {
    [super configContentView];
    
    self.usernameTextField = [[LoginTextField alloc]init];
    [self addSubview:self.usernameTextField];
    
    self.vertifyCodeTextField = [LoginTextField new];
    [self addSubview:self.vertifyCodeTextField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.loginBtn];
    
    //
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(kRate(540/2.0));
        make.left.mas_equalTo(kRate(15));
        make.right.mas_equalTo(-kRate(15));
        make.height.mas_equalTo(kRate(50));
    }];
    [self.vertifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(kRate(15));
        make.left.equalTo(self.usernameTextField);
        make.right.equalTo(self.usernameTextField);
        make.height.equalTo(self.usernameTextField);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vertifyCodeTextField.mas_bottom).with.offset(kRate(35));
        make.left.equalTo(self.usernameTextField);
        make.right.equalTo(self.usernameTextField);
        make.height.equalTo(self.usernameTextField);
    }];
    //
    self.contentView.backgroundColor = UIColorFromRGB(0x28beff);
    self.usernameTextField.leftLabel.text = @"手机号";
    self.usernameTextField.needRightBtn = true;
    self.vertifyCodeTextField.leftLabel.text = @"验证码";
    self.vertifyCodeTextField.needRightBtn = false;
    self.loginBtn.normalFont = FONT(TF20);
    self.loginBtn.normalTitle = @"登录";
    self.loginBtn.normalColor = UIColorFromRGB(0x144271);
    self.loginBtn.backgroundColor = COLOR_FFFFFF;
    
}

- (void)bindViewModel {
    self.usernameTextField.textfield.text = [HWUserLogin currentUserLogin].userPhone;
    
    self.viewModel.usernameSignal = self.usernameTextField.textfield.rac_textSignal;
    RAC(self.usernameTextField.textfield, text) = self.viewModel.usernameSignal;
    self.viewModel.vertifyCodeSignal = self.vertifyCodeTextField.textfield.rac_textSignal;

    [self.viewModel bindViewWithSignal];
    
    @weakify(self);
    // 登录
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    [self.loginBtn.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        @strongify(self);
        [Utility showMBProgress:self.view message:nil];
        [signal subscribeError:^(id x) {
            NSLog(@"响应的数据=%@",x);
        }];
    }];
    [[self.loginBtn.rac_command.executing skip:1] subscribeNext:^(id x) {
        [Utility hideMBProgress:self.view];
    }];
    [self.loginBtn.rac_command.errors subscribeNext:^(NSError *err) {
        [Utility showToastWithMessage:err.domain];
        //
        [[ViewControllersRouter shareInstance]setRootViewController:@"tabbarViewModel"];
    }];
    
    // 获取验证码
    RACChannel *codeChannel = self.viewModel.gainCodeChannel;
    self.usernameTextField.rightChannel = codeChannel;
    [codeChannel.followingTerminal subscribeNext:^(id x) {
        @strongify(self);
        [Utility showMBProgress:self.view message:@""];
    }];
    [codeChannel.leadingTerminal subscribeNext:^(id response) {
        @strongify(self);
        [Utility hideMBProgress:self.view];
        if ([response isKindOfClass:[NSString class]]) {
            [Utility showToastWithMessage:response];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
