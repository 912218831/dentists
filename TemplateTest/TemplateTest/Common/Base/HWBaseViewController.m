//
//  HWBaseViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "UIView+Utils.h"
#import "HWCustomDrawImg.h"
@interface HWBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation HWBaseViewController

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
  
   [self.navigationController.navigationBar setBackgroundImage:[Utility imageWithColor:COLOR_F9FAFA andSize:CGSizeMake(kScreenWidth, (IOS7Later ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    if (IOS7Later)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;

    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.view.backgroundColor = COLOR_FFFFFF;
    self.navigationItem.hidesBackButton = YES;
}


#pragma mark -
#pragma mark Public method

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
