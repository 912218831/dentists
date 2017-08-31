//
//  HWCountDownBtnItem.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/12.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCountDownBtnItem.h"

@implementation HWCountDownBtnItem


+ (instancetype)itemWithIconImg:(UIImage *)iconImg value:(NSString *)value {
	
    return [[self alloc]initWithIconImg:iconImg value:value placeholder:nil];
    
}

+ (instancetype)itemWithIconImg:(UIImage *)iconImg withPlaceHolder:(NSString *)placeHolder {
	
    return [[self alloc]initWithIconImg:iconImg value:nil placeholder:placeHolder];
    
}

+ (instancetype)itemWithIconImg:(UIImage *)iconImg value:(NSString *)value  placeholder:(NSString *)placeholder {
	
    return [[self alloc]initWithIconImg:iconImg value:value placeholder:placeholder];
}

- (instancetype)initWithIconImg:(UIImage *)iconImg value:(NSString *)value placeholder:(NSString *)placeholder {
    self = [super init];
    if (self)
    {
        self.iconImg = iconImg;
        self.value = value;
        self.placeholder = placeholder;
    }
    return self;
	
}
@end
