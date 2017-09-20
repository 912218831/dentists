//
//  BaseViewController.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong, readwrite) UIView         *contentView;
@end

@implementation BaseViewController

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        [[self rac_signalForSelector:@selector(viewDidLoad)]subscribeNext:^(id x) {
            @strongify(self);
            [self bindViewModel];
        }];
    }
    return self;
}

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    if (self = [self init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContentView];
}


- (void)bindViewModel {
    
}

- (void)configContentView {
    NSDictionary *params = [ViewControllerSimpleConfig viewModelSimpleConfigMappings:self.viewModel];
    
    self.navigationItem.titleView = [Utility navTitleView:[params stringObjectForKey:@"title"]];
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 22, 40);
    [leftButton setImage:[UIImage imageNamed:[params stringObjectForKey:@"leftImageName"]] forState:UIControlStateNormal];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [leftButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.navigationItem.rightBarButtonItem = [Utility navRightBackBtn:self action:@selector(rightAction) imageStr:@"rightImageName"];
    
    self.contentView = [[UIView alloc]initWithFrame:self.frame];
    [self.view addSubview:self.contentView];
}

- (void)reloadviewWhenDatasourceChange {
    
}

- (void)rightAction {
    
    
}
@end
