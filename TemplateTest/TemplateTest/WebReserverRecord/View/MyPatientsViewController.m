//
//  MyPatientsViewController.m
//  TemplateTest
//
//  Created by HW on 2017/9/26.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "MyPatientsViewController.h"

@interface MyPatientsViewController () 

@end

@implementation MyPatientsViewController

- (void)configContentView {
    [super configContentView];
    self.url = [NSURL URLWithString:@"http://www.baidu.com"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
