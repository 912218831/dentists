//
//  SetPasswordViewController.m
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "SetPasswordViewModel.h"

@interface SetPasswordViewController () <UITableViewDelegate,
                                        UITableViewDataSource>
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) SetPasswordViewModel *viewModel;
@end

@implementation SetPasswordViewController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)configContentView {
    [super configContentView];
    
    self.listView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.backgroundColor = CD_LIGHT_BACKGROUND;
    [self addSubview:self.listView];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:nil title:@"保存"];
}

- (void)bindViewModel {
    [super bindViewModel];
    [self.viewModel bindViewWithSignal];
    
    @weakify(self);
    [[self.navigationItem.rightBarButtonItem.customView rac_signalForSelector:@selector(touchesBegan:withEvent:)]subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.savePwdSignal subscribeNext:^(id x) {
            [[ViewControllersRouter shareInstance]popViewModelAnimated:true];
        }error:^(NSError *error) {
            [Utility showToastWithMessage:error.domain];
        }];
    }];
    
    [self.viewModel.fetchVCodeCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
    [self.viewModel.fetchVCodeCommand.errors subscribeNext:^(NSError *error) {
        [Utility showToastWithMessage:error.domain];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRate(10);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = CD_LIGHT_BACKGROUND;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        [cell drawTopLine];
    }
    UILabel *leftLabel = [UILabel new];
    [cell addSubview:leftLabel];
    UITextField *middleTextfield = [UITextField new];
    [cell addSubview:middleTextfield];
    if (indexPath.row==0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.normalTitle = @"验证码";
        btn.normalFont = FONT(TF15);
        btn.normalColor = CD_MainColor;
        [cell addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).with.offset(-kRate(15));
            make.centerY.equalTo(cell);
        }];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [self.viewModel.fetchVCodeCommand execute:nil];
        }];
    }
    leftLabel.font = FONT(TF15);
    leftLabel.textColor = CD_Text99;
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).with.offset(kRate(15));
        make.centerY.equalTo(cell);
    }];
    [middleTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).with.offset(kRate(116));
        make.centerY.equalTo(cell);
        make.width.mas_equalTo(kRate(179));
    }];
    switch (indexPath.row) {
        case 0:
        {
            leftLabel.text = kLabel_PhoneNumber;
            middleTextfield.attributedStr = kTextfield_PhoneNumber;
            middleTextfield.text = self.viewModel.phoneNumberStr;
        }
            break;
        case 1:
        {
            leftLabel.text = kLabel_VertifyCode;
            middleTextfield.attributedStr = kTextfield_VertifyCode;
            middleTextfield.text = self.viewModel.vertifyCodeStr;
        }
            break;
        case 2:
        {
            leftLabel.text = kLabel_Password;
            middleTextfield.attributedStr = kTextfield_Password;
            middleTextfield.text = self.viewModel.passwordStr;
        }
            break;
        default:
        {
            leftLabel.text = kLabel_ConfirmPwd;
            middleTextfield.attributedStr = kTextfield_ConfirmPwd;
            middleTextfield.text = self.viewModel.confirmPwdStr;
        }
            break;
    }
    
    [cell drawBottomLine];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
