//
//  HWCommissionViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/25.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWCommissionViewController.h"

@interface HWCommissionViewController ()

@end

@implementation HWCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configContentView {
    [super configContentView];
    self.navigationItem.titleView = [Utility navTitleView:@"提成"];
    
    self.url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"]];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}


@end
