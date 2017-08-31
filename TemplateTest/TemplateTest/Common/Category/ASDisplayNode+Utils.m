//
//  ASDisplayNode+Utils.m
//  TemplateTest
//
//  Created by zhangwei on 15/12/16.
//  Copyright © 2015年 caijingpeng.haowu. All rights reserved.
//

#import "ASDisplayNode+Utils.h"

@implementation ASDisplayNode(Utils)

- (void)drawBottomLine
{
    ASDisplayNode *divider = [[ASDisplayNode alloc] init];
    divider.backgroundColor = CD_LineColor;
    
    if (self.calculatedLayout == nil)
    {
        divider.frame = CGRectMake(0.0f, self.frame.size.height - kLineHeight, self.frame.size.width, kLineHeight);
    }
    else
    {
        divider.frame = CGRectMake(0.0f, self.calculatedSize.height - kLineHeight, self.calculatedSize.width, kLineHeight);
    }
    [self addSubnode:divider];
}

- (void)drawTopLine
{
    ASDisplayNode *divider = [[ASDisplayNode alloc] init];
    divider.backgroundColor = CD_LineColor;
    if (self.calculatedLayout == nil)
    {
        divider.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, kLineHeight);
    }
    else
    {
        divider.frame = CGRectMake(0.0f, 0.0f, self.calculatedSize.width, kLineHeight);
    }
    [self addSubnode:divider];
}

@end
