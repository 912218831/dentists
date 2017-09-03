//
//  DashLineView.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "DashLineView.h"

@interface DashLineView ()
@property (nonatomic, assign) DashLineDirection direction;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) UIColor *strokeColor;
@end
@implementation DashLineView

- (instancetype)initWithLineHeight:(CGFloat)lineHeight space:(CGFloat)space direction:(DashLineDirection)direction strokeColor:(UIColor *)color{
    if (self = [super init]) {
        self.direction = direction;
        self.space = space;
        self.lineHeight = lineHeight;
        self.backgroundColor = [UIColor clearColor];
        self.strokeColor = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, (self.direction==Vertical)?rect.size.width:rect.size.height);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGFloat lengths[] = {self.lineHeight, self.space};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0, 0);
    switch (self.direction) {
        case Vertical:
        {
            CGContextAddLineToPoint(context, 0,rect.size.height);
        }
            break;
        case Horizontal:
        default:
        {
            CGContextAddLineToPoint(context, rect.size.width, 0);
        }
            break;
    }
    CGContextStrokePath(context);
    CGContextClosePath(context);
}


@end
