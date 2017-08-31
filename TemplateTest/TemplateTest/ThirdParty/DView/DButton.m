//
//  DButton.m
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import "DButton.h"
#import "DView.h"

@interface DButton ()
{
    BOOL _isCancleHighlight;
}
@end

@implementation DButton

+ (DButton *)btn{
    return [self buttonWithType:UIButtonTypeCustom];
}

+ (DButton *)btnImg:(NSString *)img frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    return [[self btn] btnImg:img frameX:x y:y w:w h:h target:target action:action];
}

- (DButton *)btnImg:(NSString *)img frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    if (img)
    {
        [self setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    }
    
    self.frame = CGRectMake(x, y, w, h);
    
    if (target && action)
    {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/** txt frame action */
+ (DButton *)btnTxt:(NSString *)txt frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    return [self btnTxt:txt txtFont:18.0f frameX:x y:y w:w h:h target:target action:action];
}

/** txt txtFont frame action */
+ (DButton *)btnTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    return [[self btn] btnTxt:txt txtFont:tf frameX:x y:y w:w h:h target:target action:action];
}


- (DButton *)btnTxt:(NSString *)txt txtFont:(CGFloat)tf frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id)target action:(SEL)action
{
    _isCancleHighlight = NO;
    if (txt)
    {
        [self setTitle:txt forState:UIControlStateNormal];
    }
    else
    {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    
    if (tf > 0)
    {
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:tf];
    }
    else
    {
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:TF15];
    }
    
    self.frame = CGRectMake(x, y, w, h);
    
    if (target && action)
    {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

//- (void)setStyle:(DBtnStyle)style
//{
//    switch (style) {
//        case DBtnStyleMain:
//        {
//            self.userInteractionEnabled = YES;
//            [self setBackgroundImage:[DView imageWithColor:CD_MainColor andSize:self.frame.size] forState:UIControlStateNormal];
//        }
//            break;
//        default:
//            break;
//    }
//}

- (void)setTxtColor:(UIColor *)txtColor
{
    [self setTitleColor:txtColor forState:UIControlStateNormal];
}

- (void)setRadiuStyle
{
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;
}

- (void)setRadius:(CGFloat)Radius
{
    self.layer.cornerRadius = Radius;
    self.layer.masksToBounds = YES;
}


- (void)setBorder:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 0.5f;
}

- (void)setBorder:(UIColor *)borderColor borderWidth:(CGFloat)width
{
    [self setBorder:borderColor];
    self.layer.borderWidth = width;
}


- (void)cancleHighlighted
{
    _isCancleHighlight = YES;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (_isCancleHighlight)
    {
        
    }
    else
    {
        [super setHighlighted:highlighted];
    }
}

@end
