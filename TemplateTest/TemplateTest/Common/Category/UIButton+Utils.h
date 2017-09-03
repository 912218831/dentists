//
//  UIButton+Utils.h
//  Template-OC
//
//  Created by wuxiaohong on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(void);

@interface UIButton (Utils)

@property (nonatomic, copy)   NSString *normaleImgName;
@property (nonatomic, copy)   NSString *disableImgName;
@property (nonatomic, copy)   NSString *selectImgName;
@property (nonatomic, copy)   NSString *normalTitle;
@property (nonatomic, strong) UIColor  *normalColor;
@property (nonatomic, strong) UIColor  *disableColor;
@property (nonatomic, copy)   UIFont   *normalFont;
@property (nonatomic, copy)   NSString *normalIcon;
@property (nonatomic, copy)   NSString *selectIcon;

// 设置激活状态
- (void)setActiveState;

// 设置未激活状态
- (void)setInactiveState;

//圆角，颜色自定、
- (void)setBtnStyle:(UIColor *)color;

//带阴影的按钮
- (void)setButtonBackgroundShadowHighlight:(UIColor * )color;

- (void)setButtonMainStyle;

- (void)setButtonGreenStyle;

- (void)setButtonGrayStyle;


/*
 *  handleControlEvent:withBlock:
 *  使用block处理button事件
 *  入参:event 触发类型                 例: UIControlEventTouchUpInside
 *      block 满足触发条件后的事件        例:^{}
 *  注:最后入参有效,同时只能保存一个block触发事件
 */
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block;




@end
