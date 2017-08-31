//
//  HWPeopleCenterViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/25.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWPeopleCenterViewController.h"
#import "HWWebView.h"
#import "HWLoginViewController.h"
@interface HWPeopleCenterViewController ()<HWWebViewDelegate>

@end

@implementation HWPeopleCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"我的"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
