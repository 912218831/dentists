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
        [[self rac_signalForSelector:@selector(viewDidLoad)]subscribeNext:^(id x) {
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
    NSDictionary *params = [ViewControllerSimpleConfig viewModelSimpleConfigMappings:self.viewModel];
    
    self.navigationItem.titleView = [Utility navTitleView:[params stringObjectForKey:@"title"]];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    leftImageView.image = [UIImage imageNamed:[params stringObjectForKey:@"leftImageName"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftImageView];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    rightImageView.image = [UIImage imageNamed:[params stringObjectForKey:@"rightImageName"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightImageView];
}

- (void)configContentView {
    self.contentView = [[UIView alloc]initWithFrame:self.frame];
    [self.view addSubview:self.contentView];
}

- (void)reloadviewWhenDatasourceChange {
    
}
@end
