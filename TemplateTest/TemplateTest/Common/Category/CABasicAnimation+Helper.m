//
//  CABasicAnimation+Helper.m
//  基本图表视图
//
//  Created by 龙石华 on 16/3/18.
//  Copyright © 2016年 龙石华. All rights reserved.
//

#import "CABasicAnimation+Helper.h"

@interface CABasicAnimation ()

@end

@implementation CABasicAnimation (Helper)

+(instancetype)animationWithKeyPath:(NSString *)path animationDuration:(CFTimeInterval)duration timingFunction:(CAMediaTimingFunction *)timingFunction fromValue:(id)fromValue toValue:(id)toValue{

    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:path];
    pathAnimation.duration = duration;
    pathAnimation.timingFunction = timingFunction;
    pathAnimation.fromValue = fromValue;
    pathAnimation.toValue = toValue;
    
    return pathAnimation;
}

+(instancetype)animationWithKeyPath:(NSString *)path animationDuration:(CFTimeInterval)duration timingFunction:(CAMediaTimingFunction *)timingFunction fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses fillMode:(NSString *)fillMode{

    CABasicAnimation *pathAnimation = [self animationWithKeyPath:path animationDuration:duration timingFunction:timingFunction fromValue:fromValue toValue:toValue];
    pathAnimation.autoreverses = autoreverses;
    pathAnimation.fillMode = fillMode;
    
    return pathAnimation;
}

@end
