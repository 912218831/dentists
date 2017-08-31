//
//  HWCustomDrawImg.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/1/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HWCustomDrawImgBorders) {
    HWCustomDrawImgBorderLeft = 1 << 1,
    HWCustomDrawImgBorderTop = 1 << 2,
    HWCustomDrawImgBorderRight = 1 << 3,
    HWCustomDrawImgBorderBottom = 1 << 4,
};
typedef NS_ENUM(NSUInteger, HWCustonDrawImgImgPosition) {
    HWCustonDrawImgImgPositionLeft = 1 << 1,
    HWCustonDrawImgImgPositionTop = 1 << 2,
    HWCustonDrawImgImgPositionRight = 1 << 3,
    HWCustonDrawImgImgPositionBottom = 1 << 4,
};

typedef NS_ENUM(NSUInteger, HWCustomDrawImgLayoutDirection) {
    HWCustomDrawImgHorizon= 1 << 1,
    HWCustomDrawImgVertical = 1 << 2,
};


@interface HWCustomDrawImg : NSObject


//

//+ (UIImage *) 

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
+ (UIImage *)drawBorderImg:(CGSize)size borders:(HWCustomDrawImgBorders)borders fillColor:(UIColor*)fillColor borderColor:(UIColor*)borderColor lineWidth:(CGFloat)lineWidth;
//合成图片和文字
+ (UIImage *)drawImg:(CGSize)size img:(UIImage *)img text:(NSString *)text imgRect:(CGRect)imgRect textRect:(CGRect)textRect;
//绘制中心是一个图片
+ (UIImage *)drawCenterImg:(CGSize)size centerImg:(UIImage *)img backgroundColor:(UIColor *)backgroundColor;
//合成图片在不同位置的自动对齐的图片
+ (UIImage *)drawAutoSizeTextAndImg:(UIImage *)contentImg text:(NSString*)str grap:(CGFloat)grap strconfig:(NSDictionary *)strconfig imgPosition:(HWCustonDrawImgImgPosition)position;

+ (UIImage *)drawCenterImg:(UIImage *)centerImg containerImg:(UIImage *)containerImg;

//如果没有gap 默认为5
+ (UIImage * )drawAutoLayoutImgs:(NSArray *)imgs direction:(HWCustomDrawImgLayoutDirection) direction withGap:(CGFloat)gap;

+ (UIImage *)drawAutoSizeText:(CGSize) containtSize content:(NSString *)content backgroundColor:(UIColor*)color config:(NSDictionary *)contentConfig isLineBreak:(BOOL)lineBreak;

@end
