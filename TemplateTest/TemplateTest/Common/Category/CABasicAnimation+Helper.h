//
//  CABasicAnimation+Helper.h
//  基本图表视图
//
//  Created by 龙石华 on 16/3/18.
//  Copyright © 2016年 龙石华. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (Helper)

/**
 *
 *  @param path           可动画属性
 *  @param duration       动画的时间
 *  @param timingFunction 动画计时函数对象
 *  @param fromValue      开始值
 *  @param toValue        结束值
 *
 *  @return
 */
+(instancetype)animationWithKeyPath:(NSString *)path animationDuration:(CFTimeInterval)duration timingFunction:(CAMediaTimingFunction *)timingFunction fromValue:(id)fromValue toValue:(id)toValue;

+(instancetype)animationWithKeyPath:(NSString *)path animationDuration:(CFTimeInterval)duration timingFunction:(CAMediaTimingFunction *)timingFunction fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses fillMode:(NSString *)fillMode;


@end
