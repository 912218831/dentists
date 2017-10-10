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
    self.navigationItem.titleView = [Utility navTitleView:@"咨询解答"];
    
    self.url = [NSURL URLWithString:AppendHTML(kAskHTML)];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}


@end
