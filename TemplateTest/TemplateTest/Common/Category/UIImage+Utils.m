//
//  UIImage+Utils.m
//  TemplateTest
//
//  Created by 杨庆龙 on 3/18/16.
//  Copyright © 2016 caijingpeng.haowu. All rights reserved.
//

//#import "UIImage+Utils.h"
//#import <objc/runtime.h>
//static char hwImageWidth;
//static char hwImageHeight;
//
//@implementation UIImage (Utils)
//
//- (CGFloat)width
//{
//    return self.size.width;
//}
//
//- (void)setWidth:(CGFloat)width
//{
//    objc_setAssociatedObject(self, &hwImageHeight, @(width), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (CGFloat)height
//{
//    return self.size.height;
//}
//
//- (void)setHeight:(CGFloat)height
//{
//     objc_setAssociatedObject(self, &hwImageHeight, @(height), OBJC_ASSOCIATION_ASSIGN);
//}
//
//static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
//                                 float ovalHeight)
//{
//    float fw, fh;
//    
//    if (ovalWidth == 0 || ovalHeight == 0)
//    {
//        CGContextAddRect(context, rect);
//        return;
//    }
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    
//    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}
//
//+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r
//{
//    // the size of CGContextRef
//    float scaleFactor = [[UIScreen mainScreen] scale];
//    
//    int w = size.width;
//    int h = size.height;
//    
//    UIImage *img = image;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w * scaleFactor, h * scaleFactor, 8, 4 * w * scaleFactor, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    CGContextScaleCTM(context, scaleFactor, scaleFactor);
//    
//    CGContextBeginPath(context);
//    addRoundedRectToPath(context, rect, r, r);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    img = [UIImage imageWithCGImage:imageMasked];
//    
//    CGContextRelease(context);
////    CGColorSpaceRelease(colorSpace);
//    CGImageRelease(imageMasked);
//    return img;
//}
//
//
//- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
//    
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    
//    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
//    CGContextAddPath(ctx,path.CGPath);
//    CGContextClip(ctx);
//    [self drawInRect:rect];
//    CGContextDrawPath(ctx, kCGPathFillStroke);
//    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}
//
//
//@end

//
//   UIImage+Utils.m
//   TemplateTest
// 
//   Created by 杨庆龙 on 3/18/16.
//   Copyright © 2016 caijingpeng.haowu. All rights reserved.

 
 #import "UIImage+Utils.h"
 #import <objc/runtime.h>
 #import "ImageUtils.h"
 static char hwImageWidth;
 static char hwImageHeight;
 
 @implementation UIImage (Utils)
 
 - (CGFloat)width
 {
     return self.size.width;
 }
 
 - (void)setWidth:(CGFloat)width
 {
     objc_setAssociatedObject(self, &hwImageHeight, @(width), OBJC_ASSOCIATION_ASSIGN);
 }
 
 - (CGFloat)height
 {
     return self.size.height;
 }
 
 - (void)setHeight:(CGFloat)height
 {
     objc_setAssociatedObject(self, &hwImageHeight, @(height), OBJC_ASSOCIATION_ASSIGN);
 }
 
 static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
 float ovalHeight)
 {
     float fw, fh;
     
     if (ovalWidth == 0 || ovalHeight == 0)
     {
     CGContextAddRect(context, rect);
     return;
 }
 
     CGContextSaveGState(context);
     CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
     CGContextScaleCTM(context, ovalWidth, ovalHeight);
     fw = CGRectGetWidth(rect) / ovalWidth;
     fh = CGRectGetHeight(rect) / ovalHeight;
     
     CGContextMoveToPoint(context, fw, fh/2); //  Start at lower right corner
     CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);//   Top right corner
     CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
     CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
     CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);//  Back to lower right
     
     CGContextClosePath(context);
     CGContextRestoreGState(context);
 }
 
 + (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r
 {
     @autoreleasepool {
         // the size of CGContextRef
         float scaleFactor = [[UIScreen mainScreen] scale];
         
         int w = size.width;
         int h = size.height;
         
         UIImage *img = image;
         
         UIGraphicsBeginImageContextWithOptions(size,NO,scaleFactor);
         CGContextRef context = UIGraphicsGetCurrentContext();
         
         CGRect rect = CGRectMake(0, 0, w, h);
         CGContextBeginPath(context);
         addRoundedRectToPath(context, rect, r, r);
         CGContextClosePath(context);
         CGContextClip(context);
         [image drawInRect:CGRectMake(0, 0, w, h)];
         //CGImageRef imageMasked = CGBitmapContextCreateImage(context);
         //img = [UIImage imageWithCGImage:imageMasked];
         img = UIGraphicsGetImageFromCurrentImageContext();
         //CGImageRelease(imageMasked);
         return img;
     }
 }
 
 
 - (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
 
     CGRect rect = CGRectMake(0, 0, size.width, size.height);
     
     UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
     CGContextAddPath(ctx,path.CGPath);
     CGContextClip(ctx);
     [self drawInRect:rect];
     CGContextDrawPath(ctx, kCGPathFillStroke);
     UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return newImage;
 }
 
 
 @end
 
