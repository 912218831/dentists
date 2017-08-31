//
//  HWBaseAlertView.h
//  TemplateTest
//
//  Created by caijingpeng on 15/11/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HWBaseAlertView : UIView
{
    UIView *_handleView;                //操作视图
}

@property (nonatomic, strong) UIColor *backControlColor;
@property (nonatomic, strong) UIColor *handleBackColor;

/**
 *	@brief  显示Alert在Window上.
 */
- (void)show;
- (void)hide;
- (void)showWith:(UIView *)view;
- (void)hideView;

@end
