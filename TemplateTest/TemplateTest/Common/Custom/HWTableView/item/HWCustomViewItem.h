//
//  HWCustomViewItem.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/9/18.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewItem.h"

@interface HWCustomViewItem : HWTableViewItem

@property (nonatomic,strong) id customView;

+ (HWCustomViewItem *)itemWithCustomView:(id)customView;
+ (HWCustomViewItem *)itemWithCustomView:(id)customView selectHandle:(void(^)(HWCustomViewItem * item))selectHandle;

@end
