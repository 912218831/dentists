//
//  HWTitleAndLabelItem.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTitleAndLabelItem.h"
#import "HWTableViewManger.h"
#import "HWTableViewSection.h"
@implementation HWTitleAndLabelItem


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [[self alloc]initWithTitle:title withValue:nil withAccessoryImg:nil withSelctionHander:nil withIconImg:nil];

}

+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString * )value
{
    return [[self alloc]initWithTitle:title withValue:value withAccessoryImg:nil withSelctionHander:nil withIconImg:nil];

}

+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg
{
    return [[self alloc]initWithTitle:title withValue:value withAccessoryImg:accessoryImg withSelctionHander:nil withIconImg:nil];

}

+(instancetype)itemWithTitle:(NSString *)title withAccessoryImg:(UIImage *)accessoryImg
{
    return [[self alloc]initWithTitle:title withValue:nil withAccessoryImg:accessoryImg withSelctionHander:nil withIconImg:nil];
}

- (instancetype)initWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg withSelctionHander:(void(^)(HWTitleAndLabelItem * item))selectionHander withIconImg:(UIImage *)iconImg
{
    self = [super init];
    if (self)
    {
        self.title  = title;
        self.value = value;
        self.accessoryImg = accessoryImg;
        self.selectionHandler = selectionHander;
        self.iconImg = iconImg;
    }
    return self;

}

+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg withSelctionHander:(void(^)(HWTitleAndLabelItem * item))selectionHander {
    return [[self alloc]initWithTitle:title withValue:value withAccessoryImg:accessoryImg withSelctionHander:selectionHander withIconImg:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg withSelctionHander:(void(^)(HWTitleAndLabelItem * item))selectionHander withIconImg:(UIImage *)iconImg
{
    return [[self alloc]initWithTitle:title withValue:value withAccessoryImg:accessoryImg withSelctionHander:selectionHander withIconImg:iconImg];
}

+ (instancetype)itemWithTitle:(NSString *)title withIconImg:(UIImage *)iconImg withAccessroyImg:(UIImage *)accessoryImg
{
    return [[self alloc]initWithTitle:title withValue:nil withAccessoryImg:accessoryImg withSelctionHander:nil withIconImg:iconImg];
}


@end
