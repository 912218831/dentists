//
//  DoubleLabelButton.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleLabelButton : UIControl
@property (nonatomic, strong, readonly) UILabel *topLabel;
@property (nonatomic, strong, readonly) UILabel *bottomLabel;

- (instancetype)initWithTopHeight:(CGFloat)topHeight spaceY:(CGFloat)space;

@end
