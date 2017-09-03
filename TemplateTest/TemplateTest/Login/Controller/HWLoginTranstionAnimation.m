//
//  HWLoginTranstionAnimation.m
//  RDVTabBarController
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 Robert Dimitrov. All rights reserved.
//

#import "HWLoginTranstionAnimation.h"
#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@implementation HWLoginTranstionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView * containerView = [transitionContext containerView];
    //FromVC
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //toVC
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //fromView
    UIView * fromView = nil;
    //toView
    UIView * toView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    [containerView addSubview:toView];
    toView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];

}

@end
