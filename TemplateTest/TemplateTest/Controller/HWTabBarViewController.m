//
//  HWTabbBarViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/25.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HomePageViewModel.h"
#import "HWPeopleCenterViewModel.h"
#import "ReserverRecordViewModel.h"
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
    HomePageViewModel *hpViewModel = [[HomePageViewModel alloc]init];
    UIViewController *homePageController = [[ViewControllersRouter shareInstance]controllerMatchViewModel:hpViewModel];
    
    ReserverRecordViewModel *rrViewModel = [[ReserverRecordViewModel alloc]init];
    UIViewController *secondViewController = [[ViewControllersRouter shareInstance]controllerMatchViewModel:rrViewModel];
    
    UIViewController *thirdViewController = [[HWCommissionViewController alloc] init];
    
    HWPeopleCenterViewModel *pcViewModel = [[HWPeopleCenterViewModel alloc]init];
    UIViewController *fourViewController = [[ViewControllersRouter shareInstance]controllerMatchViewModel:pcViewModel];
    
    
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
    UIImage *unfinishedImage = [Utility imageWithColor:COLOR_FFFFFF andSize:CGSizeMake(1, 1)];//[UIImage imageNamed:@"tabbar_normal_background"];
    
    NSArray *unSelectedImages = @[@"首页", @"订单", @"提成",@"我的"];
    NSArray * titles = @[@"首页",@"我的病人",@"咨询解答",@"设置"];
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
}

- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
{
    [super tabBar:tabBar didSelectItemAtIndex:index];
}

- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.titleView = [Utility navTitleView:@"总览"];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
