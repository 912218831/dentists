//
//  HWCustomViewCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/9/18.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomViewCell.h"

@implementation HWCustomViewCell
@synthesize item = _item;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

- (void)setItem:(HWCustomViewItem *)item
{
    _item = item;
    for (id subView in [self.contentView subviews]) {
        [subView removeFromSuperview];
    }
    [self.contentView addSubview:_item.customView];

}

@end
