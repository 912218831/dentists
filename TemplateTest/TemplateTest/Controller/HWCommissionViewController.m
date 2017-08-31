//
//  HWCommissionViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/25.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWCommissionViewController.h"
#import "HWWebView.h"

@interface HWCommissionViewController ()<HWWebViewDelegate>

@end

@implementation HWCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"提成"];

}



@end
