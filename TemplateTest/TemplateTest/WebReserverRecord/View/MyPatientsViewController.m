//
//  MyPatientsViewController.m
//  TemplateTest
//
//  Created by HW on 2017/9/26.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "MyPatientsViewController.h"
#import "MyPatientsViewModel.h"

@interface MyPatientsViewController () 
@property (nonatomic, strong) MyPatientsViewModel *viewModel;
@end

@implementation MyPatientsViewController
@dynamic viewModel;

- (void)configContentView {
    [super configContentView];
    
    self.url = [NSURL URLWithString:self.viewModel.urlStr];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
   
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (webView.canGoBack) {
        MyPatientsViewModel *rrViewModel = [[MyPatientsViewModel alloc]init];
        rrViewModel.urlStr = webView.URL.absoluteString;
        rrViewModel.title = @"病人详情";
        rrViewModel.leftImageName = @"TOP_ARROW";
        [[ViewControllersRouter shareInstance]pushViewModel:rrViewModel animated:true];
        [webView goBack];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
