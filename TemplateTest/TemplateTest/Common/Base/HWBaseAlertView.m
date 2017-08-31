//
//  HWBaseAlertView.m
//  TemplateTest
//
//  Created by caijingpeng on 15/11/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseAlertView.h"

@implementation HWBaseAlertView

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _backControlColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    _handleBackColor = UIColorFromRGB(0xffffff);
    
    return self;
}

#pragma mark - 显示
- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:2];
    scale.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:0];
    opacity.toValue = [NSNumber numberWithFloat:1];
    
    
    [_handleView.layer addAnimation:scale forKey:@"sc"];
    [_handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = _backControlColor;
    }];
}

- (void)showWith:(UIView *)view
{
    [view addSubview:self];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:2];
    scale.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:0];
    opacity.toValue = [NSNumber numberWithFloat:1];
    
    
    [_handleView.layer addAnimation:scale forKey:@"sc"];
    [_handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = _backControlColor;
    }];
}

- (void)hide
{
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration =0.25;
    scale.fromValue = [NSNumber numberWithFloat:1];
    scale.toValue = [NSNumber numberWithFloat:0.8];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:1];
    opacity.toValue = [NSNumber numberWithFloat:0];
    
    
    [_handleView.layer addAnimation:scale forKey:@"sc"];
    [_handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = [UIColor clearColor];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)hideView
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self removeFromSuperview];
        self.backgroundColor = [UIColor clearColor];

    }completion:^(BOOL finished) {
        
    }];
    
}
@end
