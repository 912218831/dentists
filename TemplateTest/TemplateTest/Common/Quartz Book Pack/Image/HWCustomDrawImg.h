//
//  HWCustomDrawImg.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/1/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HWCustomDrawDirection) {
    HWCustomDrawLeft = 1 << 1,
    HWCustomDrawTop = 1 << 2,
    HWCustomDrawRight = 1 << 3,
    HWCustomDrawBottom = 1 << 4,
};

typedef NS_ENUM(NSUInteger, HWCustomDrawImgLayoutDirection) {
    HWCustomDrawImgHorizon= 1 << 1,
    HWCustomDrawImgVertical = 1 << 2,
};


@interface HWCustomDrawImg : NSObject


/*绘制两个箭头默认 
 /\
 /\
 
 */
+ (UIImage *)drawDobuleArrow:(HWCustomDrawDirection)direction containerSize:(CGSize)size lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor;


/*默认是尖角朝上 /\ */

+ (UIImage *)drawTriangle:(HWCustomDrawDirection)direction containerSize:(CGSize)size lineWidth:(CGFloat)lineWidth fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor;

//绘制虚线
+ (UIImage *)drawDashLineWithContainerSize:(CGSize)size lineLength:(CGFloat)length lineWidth:(CGFloat)width dash:(CGFloat *)dash color:(UIColor *)color;

//绘制实心圆
+ (UIImage *)drawSolidCircle:(CGSize)size color:(UIColor *)color;
//绘制剪切图片为环形
+(UIImage *)clipCirque:(UIImage *)img width:(CGFloat)width rect:(CGRect)rect;
+ (UIImage *)clipCirque:(UIImage *)img width:(CGFloat)width rect:(CGRect)rect startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;
+(UIImage *)drawRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size;
+ (UIImage *)drawRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size roundingCorners:(UIRectCorner)corners;
+ (UIImage *)drawRightRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size;
+ (UIImage *)drawLeftRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size;
//
+ (UIImage *)drawTextImg:(CGSize)size backgroundColor:(UIColor *)color content:(NSString *)content contentConfig:(NSDictionary *)contentConfig;
//可以单独选择边框
+ (UIImage *)drawBorderImg:(CGSize)size borders:(HWCustomDrawDirection)borders fillColor:(UIColor*)fillColor borderColor:(UIColor*)borderColor lineWidth:(CGFloat)lineWidth;
//合成图片和文字
+ (UIImage *)drawImg:(CGSize)size img:(UIImage *)img text:(NSString *)text imgRect:(CGRect)imgRect textRect:(CGRect)textRect;
//绘制中心是一个图片
+ (UIImage *)drawCenterImg:(CGSize)size centerImg:(UIImage *)img backgroundColor:(UIColor *)backgroundColor;
//合成图片在不同位置的自动对齐的图片
+ (UIImage *)drawAutoSizeTextAndImg:(UIImage *)contentImg text:(NSString*)str grap:(CGFloat)grap strconfig:(NSDictionary *)strconfig strContainerSize:(CGSize)containerSize imgPosition:(HWCustomDrawDirection)position;

+ (UIImage *)drawCenterImg:(UIImage *)centerImg containerImg:(UIImage *)containerImg;
+ (UIImage *)drawCenterInReactImg:(UIImage *)centerImg contarinerRect:(CGRect)react;

//如果没有gap 默认为5
+ (UIImage * )drawAutoLayoutImgs:(NSArray *)imgs direction:(HWCustomDrawImgLayoutDirection) direction withGap:(CGFloat)gap;

+ (UIImage *)drawAutoSizeText:(CGSize) containtSize content:(NSString *)content backgroundColor:(UIColor*)color config:(NSDictionary *)contentConfig isLineBreak:(BOOL)lineBreak;
//根据视图生成图片
+ (UIImage *)drawImageWithView:(UIView *)contentView;

//绘制渐变色图片
+(UIImage *)drawgradientImg:(UIBezierPath *)path;

//绘制圆角的图片
+(UIImage *)drawCornerRadius:(CGFloat)cornerRadius sourceImg:(UIImage * )sourceImg containerSize:(CGSize)containerSize;

@end
