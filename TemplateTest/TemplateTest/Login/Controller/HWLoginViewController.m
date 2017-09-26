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
@property (nonatomic, strong) UIImageView *iconImageView;
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
    
    self.iconImageView = [UIImageView new];
    [self addSubview:self.iconImageView];
    
    self.usernameTextField = [[LoginTextField alloc]init];
    [self addSubview:self.usernameTextField];
    
    self.vertifyCodeTextField = [LoginTextField new];
    [self addSubview:self.vertifyCodeTextField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.loginBtn];
    
    //
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(kRate(320));
    }];
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
    self.iconImageView.image = [UIImage imageNamed:@"loginIcon1"];
    self.contentView.backgroundColor = UIColorFromRGB(0x28beff);
    self.usernameTextField.leftLabel.text = @"手机号";
    self.usernameTextField.needRightBtn = true;
    self.usernameTextField.textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.usernameTextField.maxLen = 11;
    self.vertifyCodeTextField.leftLabel.text = @"验证码";
    self.vertifyCodeTextField.needRightBtn = false;
    self.vertifyCodeTextField.textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.vertifyCodeTextField.textfield.secureTextEntry = true;
    self.vertifyCodeTextField.maxLen = 6;
    self.loginBtn.normalFont = FONT(TF20);
    self.loginBtn.normalTitle = @"登录";
    self.loginBtn.normalColor = UIColorFromRGB(0x144271);
    self.loginBtn.backgroundColor = COLOR_FFFFFF;
    
}

- (void)bindViewModel {
    self.usernameTextField.textfield.text = [HWUserLogin currentUserLogin].userPhone;
    
    self.viewModel.usernameSignal = [self.usernameTextField.textfield rac_signalForControlEvents:UIControlEventAllEditingEvents];
    self.viewModel.vertifyCodeSignal = [self.vertifyCodeTextField.textfield rac_signalForControlEvents:UIControlEventAllEditingEvents];

    [self.viewModel bindViewWithSignal];
    
    @weakify(self);
    // 登录
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    [self.loginBtn.rac_command.executionSignals.switchToLatest subscribeNext:^(id value) {
        [HWCoreDataManager saveUserInfo];
        [[ViewControllersRouter shareInstance]setRootViewController:@"tabbarViewModel"];
    }];
    [[self.loginBtn.rac_command.executing skip:1] subscribeNext:^(NSNumber *x) {
        if (x.boolValue) {
            [Utility showMBProgress:self.view message:nil];
        } else {
            [Utility hideMBProgress:self.view];
        }
    }];
    [self.loginBtn.rac_command.errors subscribeNext:^(NSError *error) {
        [Utility showToastWithMessage:[error domain]];
        [HWUserLogin currentUserLogin].userPhone = @"18225523932";
        //[HWCoreDataManager saveUserInfo];
        [[ViewControllersRouter shareInstance]setRootViewController:@"tabbarViewModel"];
    }];
    
    // 获取验证码
    RACChannel *codeChannel = self.viewModel.gainCodeChannel;
    self.usernameTextField.rightChannel = codeChannel;
    [codeChannel.followingTerminal subscribeNext:^(id x) {
        @strongify(self);
        [Utility showMBProgress:self.view message:@""];
    }];
    [[codeChannel.leadingTerminal.newSwitchToLatest subscribeNext:^(id response) {
        [Utility showToastWithMessage:@"验证码已发送"];
    }error:^(NSError *error) {
        [Utility showToastWithMessage:error.domain];
    } completed:nil]finally:^{
        [Utility hideMBProgress:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
