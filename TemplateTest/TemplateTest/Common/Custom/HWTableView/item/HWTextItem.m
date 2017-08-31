//
//  HWTextItem.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTextItem.h"

@implementation HWTextItem


+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value
{
    return [[self alloc]initWithTitle:title value:value];
}

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value  placeholder:(NSString *)placeholder
{
    return [[self alloc] initWithTitle:title value:value placeholder:placeholder];
}


+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg
{
    return [[self alloc]initWithTitle:title value:value placeholder:placeholder withAccessoryImg:accessoryImg withIcomImg:nil unit:nil];
}



- (id)initWithTitle:(NSString *)title value:(NSString *)value
{
    return [self initWithTitle:title value:value placeholder:nil withAccessoryImg:nil withIcomImg:nil unit:nil];
}

- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    return [self initWithTitle:title value:value placeholder:placeholder withAccessoryImg:nil withIcomImg:nil unit:nil];
}

- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg
{
    return [self initWithTitle:title value:value placeholder:placeholder withAccessoryImg:accessoryImg withIcomImg:iconImg unit:nil];
    
}

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg
{
    
    return [[self alloc] initWithTitle:title value:value placeholder:placeholder withAccessoryImg:accessoryImg withIcomImg:iconImg unit:nil];
}

+ (instancetype)itemWithIconImg:(UIImage *)iconImg withPlaceHolder:(NSString *)placeHolder
{
    
    return [[self alloc] initWithTitle:nil value:nil placeholder:placeHolder withAccessoryImg:nil withIcomImg:nil unit:nil];
}

- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg unit:(NSString *)unit
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.value = value;
        self.placeholder = placeholder;
        self.iconImg = iconImg;
        self.accessoryImg = accessoryImg;
        self.unit = unit;
    }
    return self;

}

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg unit:(NSString *)unit
{
    return [[self alloc] initWithTitle:title value:value placeholder:placeholder withAccessoryImg:accessoryImg withIcomImg:iconImg unit:unit];
}

+ (instancetype)itemWithTitle:(NSString *)title unit:(NSString *)unit
{
    return [[self alloc] initWithTitle:title value:nil placeholder:nil withAccessoryImg:nil withIcomImg:nil unit:unit];
}

+ (instancetype)itemWithTitle:(NSString *)title withAccessoryImg:(UIImage *)accessoryImg unit:(NSString *)unit
{
    return [[self alloc] initWithTitle:title value:nil placeholder:nil withAccessoryImg:accessoryImg withIcomImg:nil unit:unit];
}


@end
