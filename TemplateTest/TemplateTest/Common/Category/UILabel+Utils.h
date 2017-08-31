//
//  UILabel+Utils.h
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

//设置行间距
- (void)setLineSpacing:(CGFloat)space;
//改变label上个别字体颜色
- (void)addAttributeWithFont:(UIFont *)font
             foregroundColor:(UIColor *)color
                       range:(NSRange)range
                        text:(NSString *)text;

@end
