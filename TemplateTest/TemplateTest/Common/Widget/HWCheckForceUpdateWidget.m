//
//  HWCheckForceUpdateWidget.m
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14/12/25.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWCheckForceUpdateWidget.h"

@interface HWCheckForceUpdateWidget()

@property(strong,nonatomic)UIView * updateView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *topView;//总视图

@end

@implementation HWCheckForceUpdateWidget
@synthesize dependView;
@synthesize reachabiltiy;

- (id)initWithDependView:(UIView *)view
{
    self = [super init];
    
    if (self)
    {
        self.dependView = view;
        _isForceUpdate = @"N";
        [self checkNetworkConnection];
    }
    
    return self;
}

/**
 *	@brief	检查网络连接
 *
 *	@return
 */
- (void)checkNetworkConnection
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.reachabiltiy = [Reachability reachabilityWithHostName:@"www.haowu.com"];
    [self.reachabiltiy startNotifier];
}

/**
 *	@brief	网络变化 回调函数
 *
 *	@param 	notify 	通知
 *
 *	@return
 */
- (void)networkChanged:(NSNotification *)notify
{
    Reachability *curReach = [notify object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus networkStatus = [curReach currentReachabilityStatus];
    switch (networkStatus)
    {
        case NotReachable:
        {
            [Utility showToastWithMessage:@"网络不给力,请稍后再试!"];
            break;
        }
        case ReachableViaWiFi:
        {
            [self checkForceUpdateVersion];
            break;
        }
        case ReachableViaWWAN:
        {
            [self checkForceUpdateVersion];
            break;
        }
        default:
            break;
    }
}

- (void)checkForceUpdateVersion
{
    HWHTTPSessionManger *httpManager = [HWHTTPSessionManger manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setPObject:@"ios" forKey:@"os"];
    [dict setPObject:App_Version forKey:@"versionCode"];
}


//强制更新新UI


- (void)showUpdate
{
    UIWindow * window = (SHARED_APP_DELEGATE).window;
    
    UIView * view = [window viewWithTag:12345];
    if (view == nil)
    {
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.topView.backgroundColor = [UIColor clearColor];
        self.topView.tag = 12345;
        [window addSubview:self.topView];
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.45;
        [self.topView addSubview:self.backgroundView];
        [self.topView bringSubviewToFront:self.backgroundView];
        
        
        self.updateView = [[UIView alloc] initWithFrame:CGRectMake(kRate(35), 0, kScreenWidth - kRate(70), kRate(318))];
        [self.topView addSubview:self.updateView];
        self.updateView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        self.updateView.backgroundColor = [UIColor clearColor];
        
        UIImageView * img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.updateView.width, kRate(95))];
        [self.updateView addSubview:img1];
        img1.image = [UIImage imageNamed:@"更新bg"];
        img1.contentMode = UIViewContentModeScaleToFill;
        
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, img1.bottom, self.updateView.width, self.updateView.height - img1.bottom)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.updateView addSubview:contentView];
        
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kRate(30), 0, self.updateView.width - kRate(60), 15)];
        [contentView addSubview:titleLab];
        titleLab.centerX = self.updateView.width/2;
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.textColor = COLOR_333333;
        titleLab.text = @"更新内容";
        titleLab.font = FONT(13);
        
        UITextView * contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(kRate(30), titleLab.bottom, self.updateView.width - kRate(60), kRate(125))];
        [contentView addSubview:contentTextView];
        titleLab.centerX = self.updateView.width/2;
        contentTextView.backgroundColor = COLOR_FFFFFF;
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.lineHeightMultiple = 1.5;
        style.alignment = NSTextAlignmentLeft;
        NSAttributedString * contentStr = [[NSAttributedString alloc] initWithString:_forceUpdateMsg attributes:@{NSForegroundColorAttributeName:COLOR_999999,NSFontAttributeName:FONT(12.0f),NSParagraphStyleAttributeName:style}];
        contentTextView.attributedText = contentStr;
        
        UIButton * ignoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, contentTextView.bottom+10, (self.updateView.width - 45)/2, kRate(37))];
        [contentView addSubview:ignoreBtn];
        [ignoreBtn setTitle:@"取消" forState:UIControlStateNormal];
        [ignoreBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        ignoreBtn.titleLabel.font = FONT(15.0f);
        
        [ignoreBtn addTarget:self action:@selector(ignoreAction) forControlEvents:UIControlEventTouchUpInside];
        CAShapeLayer * ignoreLayer = (CAShapeLayer *)ignoreBtn.layer;
        ignoreLayer.path = [UIBezierPath bezierPathWithRoundedRect:ignoreBtn.bounds cornerRadius:kRate(37)].CGPath;
        ignoreLayer.fillColor = COLOR_CCCCCC.CGColor;
        
        UIButton * updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(ignoreBtn.right+15, contentTextView.bottom+10, (self.updateView.width - 45)/2, kRate(37))];
        [contentView addSubview:updateBtn];
        [updateBtn setTitle:@"下载更新" forState:UIControlStateNormal];
        [updateBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        updateBtn.titleLabel.font = FONT(15.0f);
        [updateBtn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
        CAShapeLayer * updateLayer = (CAShapeLayer *)updateBtn.layer;
        updateLayer.path = [UIBezierPath bezierPathWithRoundedRect:updateBtn.bounds cornerRadius:kRate(37)].CGPath;
        updateLayer.fillColor = COLOR_FF7215.CGColor;

        if ([_isForceUpdate isEqualToString:@"Y"])
        {
            
            ignoreBtn.hidden = YES;
            updateBtn.width =self.updateView.width - 30;
            updateBtn.left = 15;
        }
        else
        {
            ignoreBtn.hidden = NO;
            updateBtn.width = (self.updateView.width - 45)/2;
            updateBtn.left = ignoreBtn.right+15;
        }
        
    }
    
}

- (void)hidenUpdate
{
    [self.topView removeFromWindow];
}

- (void)ignoreAction
{

    [self hidenUpdate];
}

- (void)updateAction
{
    [self hidenUpdate];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_openURL]];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
