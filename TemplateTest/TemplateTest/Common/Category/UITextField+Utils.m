//
//  UITextField+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UITextField+Utils.h"
#import <objc/message.h>

static char HWTextFieldLimitNumber;

@implementation UITextField (Utils)
+ (void)load
{
    Method existing = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method new = class_getInstanceMethod(self, @selector(_autolayout_replacementLayoutSubviews));
    
    method_exchangeImplementations(existing, new);
}

- (void)_autolayout_replacementLayoutSubviews
{
    [super layoutSubviews];
    [self _autolayout_replacementLayoutSubviews]; // not recursive due to method swizzling
    [super layoutSubviews];
}

- (NSInteger)limitNumber
{
    return  [objc_getAssociatedObject(self, &HWTextFieldLimitNumber) integerValue];
}

- (void)setLimitNumber:(NSInteger)limitNumber
{
    objc_setAssociatedObject(self, &HWTextFieldLimitNumber, [NSNumber numberWithInteger:limitNumber], OBJC_ASSOCIATION_RETAIN);
}

- (void)setAttributedStr:(NSString *)attributedStr {
    // 占位符
    NSString *str = attributedStr ;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    style.minimumLineHeight = self.font.lineHeight;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString setAttributes:@{NSFontAttributeName:FONT(28/2.0),NSForegroundColorAttributeName:COLOR_999999,
        NSParagraphStyleAttributeName:style} range:NSMakeRange(0, str.length)];
    self.attributedPlaceholder = attributedString;
}

- (void)textLimitInputNumber:(NSInteger)limitNumber
{
    NSString *toBeString = self.text;
    //键盘输入模式（IOS7以后的方法）
    if ([self.textInputMode.primaryLanguage isEqualToString:@"zh-Hans"])   //简体中文输入，包括简体拼音，健体五笔，简体手写
    {
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position)
        {
            if (self.text.length > limitNumber)
            {
                self.text = [toBeString substringToIndex:limitNumber];
            }
            
        }
        else
        {
            //            NSLog(@"此时键盘在输入 不限制");
        }
    }
    else
    {
        if (self.text.length > limitNumber)
        {
            self.text = [toBeString substringToIndex:limitNumber];
        }
    }

}

- (void)setAttributedStr:(NSString *)attributedStr position:(NSTextAlignment)alignment{
    // 占位符
    [self setAttributedStr:attributedStr font:FONT(TF14) color:UIColorFromRGB(0x999999) position:alignment];
}

- (void)setAttributedStr:(NSString *)attributedStr font:(UIFont *)font color:(UIColor *)color position:(NSTextAlignment)alignment{
    // 占位符
    NSString *str = attributedStr ;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = alignment;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString setAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:style} range:NSMakeRange(0, str.length)];
    self.attributedPlaceholder = attributedString;
}

@end
