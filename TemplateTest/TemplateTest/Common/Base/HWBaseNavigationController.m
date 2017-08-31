//
//  HWBaseNavigationController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseNavigationController.h"

@interface HWBaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation HWBaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7Later)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationBar setBackgroundImage:[Utility imageWithColor:COLOR_F9FAFA andSize:CGSizeMake(kScreenWidth, (IOS7Later ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setNavigationBarMainColor
{
    self.navigationBarHidden = NO;
}

- (void)setNavigationBarClearColor
{
    self.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
