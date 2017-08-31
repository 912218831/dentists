//
//  HWWebView.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/8/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWWebView.h"
#import <MJRefresh/MJRefresh.h>
#import "HWLoginViewController.h"
#import "HWTabBarViewController.h"
#import "HWCustomDrawImg.h"
#import <IQUIView+Hierarchy.h>
@interface HWJSModel : NSObject<TestJSExport>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@property(weak,nonatomic)UIViewController * ctrl;
@end

@interface HWWebView()<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView * webView;

@end


@implementation HWWebView

- (instancetype)initWithFrame:(CGRect)frame request:(NSURLRequest *)request
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[UIWebView alloc] initWithFrame:(CGRect){CGPointZero,frame.size}];
        [self addSubview:self.webView];
        self.webView.delegate = self;
        [self.webView loadRequest:request];
        @weakify(self);
        self.webView.scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.webView reload];
        }];

    }
    return self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewStartLoad:)]) {
        [self.delegate webViewStartLoad:self];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewLoadFail:)]) {
        [self.delegate webViewLoadFail:self];
    }

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidLoad:)]) {
        [self.delegate webViewDidLoad:self];
    }

    if (!self.context) {
        self.context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
    }
    // 打印异常
    [self.webView.scrollView.mj_header endRefreshing];

    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
    };
    // 以 JSExport 协议关联 jsObj 的方法
    HWJSModel * jsModel = [[HWJSModel alloc] init];
    
    self.context[@"jsObj"] = jsModel;
    jsModel.webView = _webView;
    jsModel.jsContext = self.context;
    jsModel.ctrl = self.viewController;
 
    
}

- (void)goBack
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

@end

@implementation HWJSModel

//退出登录
- (void)logout
{
    //退出登录
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[HWUserLogin currentUserLogin] userLogout];
        HWLoginViewController * loginCtrl = [[HWLoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginCtrl];
        nav.view.backgroundColor = [UIColor whiteColor];
        [(SHARED_APP_DELEGATE).window.rootViewController presentViewController:nav animated:YES completion:^{
            [SHARED_APP_DELEGATE.window setRootViewController:nav];
        }];

    });

}


- (void)hidenBackBtn:(NSString *)isHiden
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController * ctrl = self.ctrl;
        @weakify(ctrl);
        if ([isHiden isEqualToString:@"1"]) {
            @strongify(ctrl);
            //隐藏
            ctrl.navigationItem.leftBarButtonItem = nil;
        }
        else if([isHiden isEqualToString:@"0"])
        {
            //不隐藏
            
            if (![self.webView canGoBack]) {
                ctrl.navigationItem.leftBarButtonItem = nil;
            }
            else
            {
                UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
                leftButton.frame = CGRectMake(0, 0, 30, 20);
                [leftButton addTarget:self.webView action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
                [leftButton setImage:[HWCustomDrawImg drawCenterInReactImg:[UIImage imageNamed:@"back"] contarinerRect:CGRectMake(0, 0, 30, 20)] forState:UIControlStateNormal];
                leftButton.contentMode = UIViewContentModeCenter;
                leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
                
                UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
                ctrl.navigationItem.leftBarButtonItem = item;

            }
            
        }

    });
    
}

@end
