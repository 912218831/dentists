//
//  MyPatientsViewController.h
//  TemplateTest
//
//  Created by HW on 2017/9/26.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController
@property (nonatomic, strong) WKWebView *view;
@property (nonatomic, strong, readonly) UIProgressView *progressView;
@property (nonatomic, strong) NSURL *url;

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
@end
