//
//  HWTabbBarViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/25.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWHomePangeViewController.h"
#import "HWPeopleCenterViewController.h"
#import "HWOrderViewController.h"
#import "HWCommissionViewController.h"
#import "RDVTabBarItem.h"
@interface HWTabBarViewController ()

@end

@implementation HWTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpControllers];
    }
    return self;
}

- (void)setUpControllers
{
    UIViewController *homePageController = [[HWHomePangeViewController alloc] init];
    
    UIViewController *secondViewController = [[HWOrderViewController alloc] init];
    
    UIViewController *thirdViewController = [[HWCommissionViewController alloc] init];
    UIViewController *fourViewController = [[HWPeopleCenterViewController alloc] init];
    
    
    HWBaseNavigationController * firstNav = [[HWBaseNavigationController alloc] initWithRootViewController:homePageController];
    HWBaseNavigationController * secondNav = [[HWBaseNavigationController alloc] initWithRootViewController:secondViewController];
    HWBaseNavigationController * thirdNav = [[HWBaseNavigationController alloc] initWithRootViewController:thirdViewController];
    HWBaseNavigationController * fourNav = [[HWBaseNavigationController alloc] initWithRootViewController:fourViewController];
    
    [self setViewControllers:@[firstNav, secondNav,
                               thirdNav,fourNav]];
    [self customizeTabBarForController];

}

- (void)customizeTabBarForController{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    
    NSArray *unSelectedImages = @[@"首页", @"订单", @"提成",@"我的"];
    NSArray * titles = @[@"总览",@"订单",@"提成",@"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"click%@",
                                                      [unSelectedImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[unSelectedImages objectAtIndex:index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = [titles pObjectAtIndex:index];
        item.titlePositionAdjustment = UIOffsetMake(0, 5);
        index++;
    }
    [self customizeInterface];
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
{
    [super tabBar:tabBar didSelectItemAtIndex:index];
//    if (index == 0) {
//        //首页
//        self.navigationItem.titleView = [Utility navTitleView:@"总览"];
//    }
//    else if(index == 1)
//    {
//        self.navigationItem.titleView = [Utility navTitleView:@"订单"];
//    }
//    else if (index == 2)
//    {
//        self.navigationItem.titleView = [Utility navTitleView:@"提成"];
//    }
//    else if(index == 3)
//    {
//        self.navigationItem.titleView = [Utility navTitleView:@"我的"];
//    }
    
}

- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.titleView = [Utility navTitleView:@"总览"];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
