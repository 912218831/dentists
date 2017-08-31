//
//  HWWebView.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/8/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSExport <JSExport>

- (void)logout;
- (void)hidenBackBtn:(NSString *)isHiden;
@end

@class HWWebView;

@protocol HWWebViewDelegate <NSObject>
@optional
- (void)webViewDidLoad:(HWWebView *)webView;
- (void)webViewStartLoad:(HWWebView *)webView;
- (void)webViewLoadFail:(HWWebView *)webView;

@end

@interface HWWebView : UIView
@property(strong,nonatomic)id<HWWebViewDelegate> delegate;

@property (strong, nonatomic) JSContext *context;

-(instancetype)initWithFrame:(CGRect)frame request:(NSURLRequest *)request;


@end
