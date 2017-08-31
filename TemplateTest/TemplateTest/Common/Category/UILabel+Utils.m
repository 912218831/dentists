//
//  UILabel+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)
/**
 *  计算行间距
 *
 *  @param space 位置
 */
- (void)setLineSpacing:(CGFloat)space
{
    if (self.text == nil)
    {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = space;
    NSRange range = NSMakeRange(0, [[NSString alloc]initWithString:self.text].length);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributedText = attributedString;
}
/**
 *  改变label上个别字体颜色
 *
 *  @param font  字体大小
 *  @param color 字体颜色
 *  @param range 范围
 *  @param text  字符串
 */
- (void)addAttributeWithFont:(UIFont *)font
             foregroundColor:(UIColor *)color
                       range:(NSRange)range
                        text:(NSString *)text
{
    if (nil == self.text)
    {
        return;
    }
    NSMutableAttributedString * attribuStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    if (nil != font)
    {
        [attribuStr addAttribute:NSFontAttributeName value:font range:range];
    }
    
    if (nil != color)
    {
        [attribuStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    self.attributedText = attribuStr;
}

@end
