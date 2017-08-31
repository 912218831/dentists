//
//  HWCustomViewItem.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/9/18.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomViewItem.h"

@implementation HWCustomViewItem

+(HWCustomViewItem *)itemWithCustomView:(id)customView
{
    return [[self alloc] initWithCustomView:customView withSelectedHandle:nil];

}

+ (HWCustomViewItem *)itemWithCustomView:(id)customView selectHandle:(void (^)(HWCustomViewItem *))selectHandle
{
    return [[self alloc] initWithCustomView:customView withSelectedHandle:selectHandle];

}

- (instancetype)initWithCustomView:(id)customView withSelectedHandle:(void(^)(HWCustomViewItem * item))selectedHandle
{
    self = [super init];
    if (self)
    {
        self.customView = customView;
        self.selectionHandler = selectedHandle;
    }
    return self;

}

@end
