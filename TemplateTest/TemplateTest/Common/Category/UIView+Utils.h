//
//  UIView+Utils.h
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^removeFromWindowAnimation)(void);

@interface UIView (Utils)



@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint originalPoint;
@property (nonatomic, strong) NSString *nameTag;

@property (nonatomic, copy) removeFromWindowAnimation animation;



//- (UIViewController *)viewController;
- (UIView *)viewWithNameTag:(NSString *)nameTag;

//得到View的最低点
-(CGFloat)getLowestPoint:(UIView *)view;


//画顶部的线
- (void)drawTopLine;
-(void)drawTopLineLeftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge;

//画底部的线
- (void)drawBottomLine;
- (void)drawBottomLineLeftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge;

//画顶部的线
- (void)drawTopLineByView;
- (void)drawBottomByView;

- (void)removeBottomLine;

- (void)showInWindowWithAnimation:(void(^)(void))animation;
- (void)removeFromWindow;

- (void)layoutSubViewHorizontal;
- (void)layoutSubViewVertical;

-(void)setLayercornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds;


@end

@protocol PublicInitializeProtocol <NSObject>

- (void)_initSubViews;
- (void)_layoutSubviews;
- (void)_assemblySubViews;

@end
