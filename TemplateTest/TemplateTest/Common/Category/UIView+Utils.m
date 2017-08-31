//
//  UIView+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UIView+Utils.h"
#import <ALView+PureLayout.h>
#import <objc/runtime.h>

int  topLineTag = 1000000;
int bottomLineTag = 1000001;

static char hwBackView;
static char hwAlphaView;
static char hwAnimation;
static char hwNameTag;

@interface UIView(utils)

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIControl *alphaView;


@end

@implementation UIView (Utils)


//- (UIViewController *)viewController
//{
//    UIResponder *next = self.nextResponder;
//    do{
//        if ([next isKindOfClass:[UIViewController class]]) {
//            return (UIViewController*) next;
//        }
//        next = next.nextResponder;
//        
//    }while (next !=nil);
//    
//    return nil;
//}

- (void)setBackView:(UIView *)backView
{
    objc_setAssociatedObject(self, &hwBackView, backView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)backView
{
    return objc_getAssociatedObject(self, &hwBackView);
}

- (void)setAlphaView:(UIView *)alphaView
{
    objc_setAssociatedObject(self, &hwAlphaView, alphaView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)alphaView
{
   return objc_getAssociatedObject(self, &hwAlphaView);
}

- (void)setAnimation:(removeFromWindowAnimation)animation
{

    objc_setAssociatedObject(self, &hwAnimation, animation, OBJC_ASSOCIATION_COPY);
}

- (removeFromWindowAnimation)animation
{
   return objc_getAssociatedObject(self, &hwAnimation);
}

- (NSString *)nameTag
{
    return objc_getAssociatedObject(self, &hwNameTag);
    
}

- (void)setNameTag:(NSString *)nameTag
{
    objc_setAssociatedObject(self, &hwNameTag, nameTag, OBJC_ASSOCIATION_COPY);
}

- (UIView *)viewWithNameTag:(NSString *)nameTag
{
    
    for (NSInteger i = self.subviews.count - 1; i >= 0; i--)
    {
        
        UIView * subView = [self.subviews pObjectAtIndex:i];
        if ([subView.nameTag isEqualToString:nameTag]) {
            return subView;
            break;
        }
    }
    return nil;
}

/**
 * 画顶部的线
 */
-(void)drawTopLineLeftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge
{
    if ([self viewWithTag:topLineTag] != nil) {
        [[self viewWithTag:topLineTag] removeFromSuperview];
        
    }
    UIImageView * line =[UIImageView newAutoLayoutView];
    line.tag = topLineTag;
    [self addSubview:line];
//    line.layer.masksToBounds = true;
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, leftEdge, 0, rightEdge) excludingEdge:ALEdgeBottom];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
      line.backgroundColor = CD_LineColor;
    
}

- (void)drawTopLine
{
    [self drawTopLineLeftEdge:0.0f rightEdge:0.0f];
}

- (void)drawBottomLineLeftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge
{
    if ([self viewWithTag:bottomLineTag] != nil) {
        [[self viewWithTag:bottomLineTag] removeFromSuperview];
        
    }
    UIImageView *line = [UIImageView newAutoLayoutView];
    line.tag = bottomLineTag;
//    line.layer.masksToBounds = YES;
//    line.clipsToBounds = YES;
    [self addSubview:line];
    
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, leftEdge, 0, rightEdge) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    //    line.image = [Utility imageWithColor:CD_LineColor andSize:size];
    line.backgroundColor = CD_LineColor;
//    line.image = [Utility imageWithColor:CD_LineColor andSize:(CGSize){kScreenWidth,kLineHeight}];
}

//画底部的线
- (void)drawBottomLine
{
    [self drawBottomLineLeftEdge:0.0f rightEdge:0.0f];
}


- (void)removeBottomLine
{
    UIImageView * bottomLine = [self viewWithTag:bottomLineTag];
    if (bottomLine) {
        [bottomLine removeFromSuperview];
    }
}

- (void)drawTopLineByView {
    UIView *liner = [UIView newAutoLayoutView];
    [self addSubview:liner];
    liner.backgroundColor = COLOR_E0E0E0;
    
    [liner autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [liner autoSetDimension:ALDimensionHeight toSize:0.5];
}

- (void)drawBottomByView {
    UIView * liner = [UIView newAutoLayoutView];
    [self addSubview:liner];
    liner.backgroundColor = COLOR_DEDEDE;
    
    [liner autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [liner autoSetDimension:ALDimensionHeight toSize:0.5];
}


- (void)showInWindowWithAnimation:(void (^)(void))animation
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backView.backgroundColor = [UIColor clearColor];

    self.alphaView = [[UIControl alloc] initWithFrame:self.backView.bounds];
    self.alphaView.alpha = 0.0;
    self.alphaView.backgroundColor = [UIColor blackColor];
    [self.alphaView addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [[SHARED_APP_DELEGATE window] addSubview:self.backView];
    [[SHARED_APP_DELEGATE window] addSubview:self.alphaView];
    [[SHARED_APP_DELEGATE window] addSubview:self];
    if (animation) {
        animation();
    }
    [UIView animateWithDuration:0.2 animations:^{
       
        self.alphaView.alpha = 0.4;
        
    }];

}

+(Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)removeFromWindow
{
    if (self.animation)
    {
        self.animation();
    }
    [UIView animateWithDuration:0.2 animations:^{

        self.alphaView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self.alphaView removeFromSuperview];
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(CGFloat)getLowestPoint:(UIView *)view
{
    return view.frame.origin.y+view.frame.size.height;
}


- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    self.frame = (CGRect){self.frame.origin,size};
}

- (CGPoint)originalPoint
{
    return self.frame.origin;
}

- (void)setOriginalPoint:(CGPoint)originalPoint
{
    self.frame = (CGRect){originalPoint,self.frame.size};
}


- (void)layoutSubViewHorizontal
{


}

- (void)layoutSubViewVertical
{

    NSArray * subViews = self.subviews;
    CGFloat maxWidth = 0.0;
    CGFloat maxHeight = 0.0;
    NSInteger index = 0;
    
    CGFloat totalHeight = 0.0;
    CGFloat totalWidth = 0.0;
    for (UIView * subView in subViews)
    {
        totalWidth += subView.width;
        totalHeight += subView.height;
    }
    CGFloat space = (self.width-totalWidth)/(self.subviews.count - 1);
    for (UIView * subView in subViews)
    {
        if (subView.width > maxWidth) {
            maxWidth = subView.width;
        }
        if (subView.height > maxHeight) {
            maxHeight = subView.height;
        }
        if (index == 0)
        {
            subView.centerY = subView.height/2;
        }
        else
        {
            UIView * previousView = subViews[index-1];
            subView.centerY = subView.height/2 + space + previousView.bottom;
        }
        
        subView.centerX = maxWidth/2;
        index++;
    }
}

-(void)setLayercornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
