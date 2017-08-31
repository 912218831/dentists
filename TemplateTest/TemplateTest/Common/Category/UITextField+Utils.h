//
//  UITextField+Utils.h
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Utils)
//+ (void)load;
//- (void)_autolayout_replacementLayoutSubviews;
@property (nonatomic, copy, readwrite) NSString *attributedStr;
@property(assign,nonatomic)NSInteger limitNumber;
//限制输入的个数
- (void)textLimitInputNumber:(NSInteger)limitNumber;


@end
