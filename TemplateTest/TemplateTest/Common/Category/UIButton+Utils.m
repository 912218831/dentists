//
//  UIButton+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UIButton+Utils.h"
#import <objc/runtime.h>

@implementation UIButton (Utils)
- (void)setActiveState
{
    self.userInteractionEnabled = YES;
    self.titleLabel.alpha = 1.0f;
}

- (void)setInactiveState
{
    self.userInteractionEnabled = NO;
    self.titleLabel.alpha = 0.5f;
}

- (void)setBtnStyle:(UIColor *)color
{
    [self setBackgroundImage:[Utility imageWithColor:color andSize:self.frame.size] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5f;
    self.layer.masksToBounds = YES;

}

-(void)setButtonBackgroundShadowHighlight:(UIColor *)color
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.3;
    self.backgroundColor = color;
}

- (void)setButtonMainStyle
{
    [self setBtnStyle:CD_MainColor];
    self.titleLabel.font = FONT(18.0f);
}

- (void)setButtonGreenStyle
{
    [self setBtnStyle:CD_Green];
    self.titleLabel.font = FONT(18.0f);
}

- (void)setButtonGrayStyle
{
    [self setBtnStyle:CD_Text99];
    self.titleLabel.font = FONT(18.0f);
}

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block
{
    
    objc_setAssociatedObject(self, &"myBlock", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(blockEvent:)
   forControlEvents:event];
}
-(void)blockEvent:(UIButton *)sender
{
    ActionBlock block=objc_getAssociatedObject(self, &"myBlock");
    if(block){
        block();
    }
}

- (void)setNormaleImgName:(NSString *)normaleImgName {
    [self setBackgroundImage:[UIImage imageNamed:normaleImgName] forState:UIControlStateNormal];
}

- (void)setDisableImgName:(NSString *)disableImgName {
    [self setBackgroundImage:[UIImage imageNamed:disableImgName] forState:UIControlStateDisabled];
}

- (void)setSelectImgName:(NSString *)selectImgName {
    [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
}

- (void)setNormalTitle:(NSString *)normalTitle {
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (void)setNormalColor:(UIColor *)normalColor {
    [self setTitleColor:normalColor forState:UIControlStateNormal];
}

- (void)setNormalFont:(UIFont *)normalFont {
    self.titleLabel.font = normalFont;
}

- (void)setNormalIcon:(NSString *)normalIcon {
    [self setImage:[UIImage imageNamed:normalIcon] forState:UIControlStateNormal];
}

- (void)setSelectIcon:(NSString *)selectIcon {
    [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
}

@end
