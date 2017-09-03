//
//  DashLineView.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DashLineDirection){
    Horizontal, //
    Vertical
};

@interface DashLineView : UIView

- (instancetype)initWithLineHeight:(CGFloat)lineHeight space:(CGFloat)space direction:(DashLineDirection)direction strokeColor:(UIColor *)color;

@end
