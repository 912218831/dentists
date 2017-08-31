//
//  HWCustomSliderTracker.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/7/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomSliderTracker.h"
#import "HWCustomSlider.h"
@implementation HWCustomSliderTracker

- (void)drawInContext:(CGContextRef)ctx{
    if (_customSlider) {
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.bounds];
        CGContextAddPath(ctx, path.CGPath);
        CGContextSetFillColorWithColor(ctx, _customSlider.trackColor.CGColor);
        CGContextFillPath(ctx);
        
        CGContextSetFillColorWithColor(ctx, _customSlider.trackHighlightTintColor.CGColor);
        CGFloat leftValuePosition = [_customSlider positionForValue:_customSlider.leftValue];
        CGFloat rightValuePosition = [_customSlider positionForValue:_customSlider.rightValue];
        CGRect rect = CGRectMake(leftValuePosition,0.0,rightValuePosition - leftValuePosition,CGRectGetHeight(self.bounds));
        CGContextFillRect(ctx, rect);
    }
}

@end
