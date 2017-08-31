//
//  DButton.h
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DButton : UIButton

/*
 *  各属性传nil或0，取默认值
 *  默认值：    tf = 15；txt = @"button"; action为空
 *
 */


/** txt frame action */
+ (DButton *)btnTxt:(NSString *)txt frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;

/** txt txtFont frame action */
+ (DButton *)btnTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;

+ (DButton *)btnImg:(NSString *)img frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action;


//- (void)setStyle:(DBtnStyle)style;

- (void)setTxtColor:(UIColor *)txtColor;

- (void)setRadiuStyle;

- (void)setRadius:(CGFloat)Radius;

- (void)setBorder:(UIColor *)borderColor;

- (void)setBorder:(UIColor *)borderColor borderWidth:(CGFloat)width;

- (void)cancleHighlighted;


@end

