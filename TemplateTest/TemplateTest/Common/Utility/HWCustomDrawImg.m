//
//  HWCustomDrawImg.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/1/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomDrawImg.h"
#import "BaseGeometry.h"
#import "BezierUtils.h"
@implementation HWCustomDrawImg

+ (UIImage *)drawSolidCircle:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //UIColor* color = [UIColor colorWithRed: 1 green: 0.525 blue: 0.204 alpha: 1];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [ovalPath fill];

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)drawDashLineWithContainerSize:(CGSize)size lineLength:(CGFloat)length lineWidth:(CGFloat)width dash:(CGFloat *)dash color:(UIColor *)color
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(length, width);
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, size.height/2)];
    [bezierPath addLineToPoint: CGPointMake(length, size.height/2)];
    [color setStroke];
    bezierPath.lineWidth = width;
    [bezierPath setLineDash: dash count: 2 phase: 0];
    [bezierPath stroke];
    
    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}

+ (UIImage *)clipCirque:(UIImage *)img width:(CGFloat)width rect:(CGRect)rect startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
{
    CGRect mainReact = SizeMakeRect(rect.size);
    CGRect innerRect = SizeMakeRect(CGSizeMake(rect.size.width - 2*width, rect.size.width - 2*width));
    CGPoint ovalCenter = RectGetCenter(mainReact);
    
    UIGraphicsBeginImageContextWithOptions(mainReact.size, NO, [UIScreen mainScreen].scale);
    
    FillRect(mainReact, [UIColor clearColor]);
    
    UIBezierPath* oval2Path = [UIBezierPath bezierPath];
    [oval2Path addArcWithCenter: ovalCenter radius: CGRectGetWidth(mainReact) / 2 startAngle: startAngle * M_PI/180 endAngle: endAngle * M_PI/180 clockwise: YES];
    [oval2Path addLineToPoint: ovalCenter];
    
    
    UIBezierPath* oval3Path = [UIBezierPath bezierPath];
    [oval3Path addArcWithCenter: ovalCenter radius: CGRectGetWidth(innerRect) / 2 startAngle: startAngle * M_PI/180 endAngle: endAngle * M_PI/180 clockwise: YES];
    [oval3Path addLineToPoint: ovalCenter];
    oval2Path.usesEvenOddFillRule = YES;
    
    [oval2Path appendPath:oval3Path];
    [oval2Path addClip];
    
    
    [img drawInRect:mainReact];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;


}

+ (UIImage *)clipCirque:(UIImage *)img width:(CGFloat)width rect:(CGRect)rect
{

    return [self clipCirque:img width:width rect:rect startAngle:0 endAngle:360];
}


+(UIImage *)drawRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size
{
    return [HWCustomDrawImg drawRectangle:cornerRadius color:color size:size roundingCorners:UIRectCornerAllCorners];
}
+ (UIImage *)drawLeftRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size
{

    return [HWCustomDrawImg drawRectangle:cornerRadius color:color size:size roundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft];

}

+ (UIImage *)drawRightRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size 
{
    
    return [HWCustomDrawImg drawRectangle:cornerRadius color:color size:size roundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight];
    
}


+ (UIImage *)drawRectangle:(CGFloat)cornerRadius color:(UIColor *)color size:(CGSize)size roundingCorners:(UIRectCorner)corners
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: SizeMakeRect(size) byRoundingCorners: corners cornerRadii: CGSizeMake(cornerRadius, cornerRadius)];
    [rectanglePath closePath];
    [color setFill];
    [rectanglePath fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (UIImage *)drawTextImg:(CGSize)size backgroundColor:(UIColor *)color content:(NSString *)content contentConfig:(NSDictionary *)contentConfig
{

    if (contentConfig == nil) {
        NSMutableParagraphStyle* rectangleStyle = [NSMutableParagraphStyle new];
        rectangleStyle.alignment = NSTextAlignmentCenter;
        rectangleStyle.lineBreakMode = NSLineBreakByCharWrapping;
        contentConfig = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:FONT(15.0f),NSParagraphStyleAttributeName:rectangleStyle};
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rectangleRect = SizeMakeRect(size);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
    [color setFill];
    [rectanglePath fill];
    {
        NSString* textContent = content;
        
        NSDictionary* rectangleFontAttributes = [contentConfig mutableCopy];
        if (![rectangleFontAttributes objectForKey:NSParagraphStyleAttributeName])
        {
            NSMutableParagraphStyle* rectangleStyle = [NSMutableParagraphStyle new];
            rectangleStyle.alignment = NSTextAlignmentCenter;
            rectangleStyle.lineBreakMode = NSLineBreakByCharWrapping;
            [rectangleFontAttributes setValue:rectangleStyle forKey:NSParagraphStyleAttributeName];
        }
        CGFloat rectangleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rectangleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rectangleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rectangleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rectangleRect), CGRectGetMinY(rectangleRect) + (CGRectGetHeight(rectangleRect) - rectangleTextHeight) / 2, CGRectGetWidth(rectangleRect), rectangleTextHeight) withAttributes: rectangleFontAttributes];
        CGContextRestoreGState(context);
    }
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)drawBorderImg:(CGSize)size borders:(HWCustomDrawImgBorders)borders fillColor:(UIColor*)fillColor borderColor:(UIColor*)borderColor lineWidth:(CGFloat)lineWidth
{

        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        // Rectangle Drawing
        CGRect rect = SizeMakeRect(size);
        CGFloat width = size.width;
        CGFloat height = size.height;
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
        [fillColor setFill];
        [rectanglePath fill];
        
        
        // 上边框
        if (borders & HWCustomDrawImgBorderTop)
        {
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(0, 0)];
            [bezierPath addLineToPoint: CGPointMake(width, 0)];
            [borderColor setStroke];
            bezierPath.lineWidth = lineWidth;
            [bezierPath stroke];
        }
        
        
        // 右边框
        if (borders & HWCustomDrawImgBorderRight)
        {
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(width, 0)];
            [bezier2Path addLineToPoint: CGPointMake(width, height)];
            [borderColor setStroke];
            bezier2Path.lineWidth = lineWidth;
            [bezier2Path stroke];

        }
        
        
        // 下边框
        if (borders & HWCustomDrawImgBorderBottom)
        {
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(width, height)];
            [bezier3Path addLineToPoint: CGPointMake(0, height)];
            [borderColor setStroke];
            bezier3Path.lineWidth = lineWidth;
            [bezier3Path stroke];

        }
        
        
        // 左边框
        if (borders & HWCustomDrawImgBorderLeft)
        {
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(0, height)];
            [bezier4Path addLineToPoint: CGPointMake(0, 0)];
            [borderColor setStroke];
            bezier4Path.lineWidth = lineWidth;
            [bezier4Path stroke];

        }
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (UIImage *)drawImg:(CGSize)size img:(UIImage *)img text:(NSString *)text imgRect:(CGRect)imgRect textRect:(CGRect)textRect
{
    //// General Declarations
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Image Declarations
    UIImage* image = img;
    
    //// Rectangle Drawing
    CGRect rectangleRect = SizeMakeRect(size);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    [image drawInRect: imgRect];
    CGContextRestoreGState(context);
    {
        NSString* textContent = text;
        NSMutableParagraphStyle* rectangleStyle = [NSMutableParagraphStyle new];
        rectangleStyle.alignment = NSTextAlignmentLeft;
        rectangleStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary* rectangleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 12], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: rectangleStyle};        
        CGContextSaveGState(context);
        CGContextClipToRect(context, rectangleRect);
        [textContent drawInRect: textRect withAttributes: rectangleFontAttributes];
        CGContextRestoreGState(context);
    }
    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}



+ (UIImage *)drawCenterImg:(CGSize)size centerImg:(UIImage *)img backgroundColor:(UIColor *)backgroundColor
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: SizeMakeRect(size)];
        [backgroundColor setFill];
        [rectanglePath fill];
        //// Rectangle 2 Drawing
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: SizeMakeRect(size)];
        CGContextSaveGState(context);
        [rectangle2Path addClip];
        [img drawInRect: CGRectMake((size.width - img.size.width)/2,(size.height - img.size.height)/2, img.size.width, img.size.height)];
        CGContextRestoreGState(context);
    }
    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}



+ (UIImage *)drawAutoSizeTextAndImg:(UIImage *)contentImg text:(NSString*)str grap:(CGFloat)grap strconfig:(NSDictionary *)strconfig imgPosition:(HWCustonDrawImgImgPosition)position
{
    CGSize contentSize;
    CGRect imgRect;
    CGRect textRect;
    CGSize textContentSize = [str boundingRectWithSize: CGSizeMake(INFINITY, 15)  options: NSStringDrawingUsesLineFragmentOrigin attributes: strconfig context: nil].size;
    CGSize imgSize = [contentImg size];
    switch (position) {
        case HWCustonDrawImgImgPositionTop:
        {
            if (imgSize.width > textContentSize.width) {
                contentSize = CGSizeMake(imgSize.width, imgSize.height+textContentSize.height+grap);
                imgRect = CGRectMake(0, 0, imgSize.width, imgSize.height);
                textRect = CGRectMake((imgSize.width - textContentSize.width)/2, imgSize.height+grap, textContentSize.width, textContentSize.height);
            }
            else
            {
                contentSize = CGSizeMake(textContentSize.width, imgSize.height+textContentSize.height+grap);
                imgRect = CGRectMake((textContentSize.width - imgSize.width)/2, 0, imgSize.width, imgSize.height);
                textRect = CGRectMake(0, imgSize.height+grap, textContentSize.width, textContentSize.height);
            }
        }
            break;
        case HWCustonDrawImgImgPositionLeft:
        {
            if (imgSize.height > textContentSize.height) {
                contentSize = CGSizeMake(imgSize.width+grap+textContentSize.width, imgSize.height);
                imgRect = CGRectMake(0, 0, imgSize.width, imgSize.height);
                textRect = CGRectMake(imgSize.width+grap, (imgSize.height -textContentSize.height)/2, textContentSize.width, textContentSize.height);

            }
            else
            {
                contentSize = CGSizeMake(imgSize.width+grap+textContentSize.width, textContentSize.height);
                imgRect = CGRectMake(0, (textContentSize.height -imgSize.height)/2, imgSize.width, imgSize.height);
                textRect = CGRectMake(imgSize.width+grap, 0, textContentSize.width, textContentSize.height);

            }

        }
            break;
        case HWCustonDrawImgImgPositionRight:
        {
            if (imgSize.height > textContentSize.height) {
                contentSize = CGSizeMake(imgSize.width+grap+textContentSize.width, imgSize.height);
                imgRect = CGRectMake(textContentSize.width+grap, 0, imgSize.width, imgSize.height);
                textRect = CGRectMake(0, (imgSize.height -textContentSize.height)/2, textContentSize.width, textContentSize.height);
                
            }
            else
            {
                //////
                contentSize = CGSizeMake(imgSize.width+grap+textContentSize.width, textContentSize.height);
                imgRect = CGRectMake(textContentSize.width+grap, (textContentSize.height -imgSize.height)/2, imgSize.width, imgSize.height);
                textRect = CGRectMake(0, 0, textContentSize.width, textContentSize.height);
                
            }

        }
            break;
        case HWCustonDrawImgImgPositionBottom:
        {
            if (imgSize.width > textContentSize.width) {
                contentSize = CGSizeMake(imgSize.width, imgSize.height+textContentSize.height+grap);
                textRect = CGRectMake((imgSize.width - textContentSize.width)/2, 0, textContentSize.width, textContentSize.height);
                imgRect = CGRectMake(0, textContentSize.height+grap, imgSize.width, imgSize.height);
            }
            else
            {
                contentSize = CGSizeMake(textContentSize.width, imgSize.height+textContentSize.height+grap);
                textRect = CGRectMake(0, 0, textContentSize.width, textContentSize.height);
                imgRect = CGRectMake((textContentSize.width - imgSize.width)/2, textContentSize.height+grap, imgSize.width, imgSize.height);
            }

        }
            break;
        default:
            break;
    }

    
    //// General Declarations
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, [UIScreen mainScreen].scale);

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Rectangle 2 Drawing
    CGRect rectangle2Rect = SizeMakeRect(contentSize);
    {
        NSString* textContent = str;
        
        NSDictionary* rectangle2FontAttributes = strconfig;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rectangle2Rect);
        [textContent drawInRect: textRect withAttributes: rectangle2FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: imgRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    [contentImg drawInRect: imgRect];
    CGContextRestoreGState(context);

    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}


+ (UIImage *)drawCenterImg:(UIImage *)centerImg containerImg:(UIImage *)containerImg
{
    UIGraphicsBeginImageContextWithOptions(containerImg.size, NO, [UIScreen mainScreen].scale);
    CGRect containerRect = SizeMakeRect(containerImg.size);
    CGRect centerRect = CGRectInset(containerRect, (containerImg.size.width - centerImg.size.width)/2, (containerImg.size.height - centerImg.size.height)/2);
    
    [containerImg drawInRect:containerRect];
    [centerImg drawInRect:centerRect];
    
    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}

+ (UIImage * )drawAutoLayoutImgs:(NSArray *)imgs direction:(HWCustomDrawImgLayoutDirection) direction withGap:(CGFloat)gap
{
    if (imgs == nil) {
        return nil;
    }
    CGFloat totalHeight = 0.0;
    CGFloat totalWidth = 0.0;
    CGFloat maxWidth = 0.0;
    CGFloat maxHeight = 0.0;
    for (UIImage * img in imgs) {
        totalWidth += img.size.width;
        totalHeight+= img.size.height;
        maxWidth = MAX(maxWidth, img.size.width);
        maxHeight = MAX(maxHeight, img.size.height);
    }
    
    gap = gap ? gap: 5.0f;
    
    CGFloat canvasWidth = 0.0;
    CGFloat canvasHeight = 0.0;
    switch (direction) {
        case HWCustomDrawImgHorizon:
        {
            canvasWidth = totalWidth + gap * (imgs.count - 1);
            canvasHeight = maxHeight;
        }
            break;
        case HWCustomDrawImgVertical:
        {
            canvasWidth = maxWidth;
            canvasHeight = totalHeight + gap*(imgs.count - 1);
        }

            break;
        default:
            return nil;
            break;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(canvasWidth, canvasHeight), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (direction == HWCustomDrawImgHorizon)
    {
        CGFloat centerX = 0.0;
        CGFloat preRight = 0;
        for (NSInteger index = 0; index < imgs.count; index++)
        {
            
            UIImage * img = [imgs objectAtIndex:index];
            if (index == 0) {
                centerX = img.size.width/2;
            }
            else
            {
                centerX = preRight + img.size.width/2 + gap;
            }
            CGPoint drawCenter = CGPointMake(centerX, canvasHeight/2);
            CGRect drawRect = CenterAndSizeMakeRect(drawCenter,img.size);
            UIBezierPath* drawPath = [UIBezierPath bezierPathWithRect: drawRect];
            CGContextSaveGState(context);
            [drawPath addClip];
            [img drawInRect: drawRect];
            CGContextRestoreGState(context);
            preRight = CGRectGetMaxX(drawRect);
        }

    }
    else
    {
        CGFloat centerY = 0.0;
        CGFloat preBottom = 0;

        for (NSInteger index = 0; index < imgs.count; index++)
        {
            UIImage * img = [imgs objectAtIndex:index];
            if (index == 0) {
                centerY = img.size.height/2;
            }
            else
            {
                centerY = preBottom + img.size.height/2 + gap;
            }
            CGPoint drawCenter = CGPointMake(canvasWidth/2, centerY);
            CGRect drawRect = CenterAndSizeMakeRect(drawCenter,img.size);
            UIBezierPath* drawPath = [UIBezierPath bezierPathWithRect: drawRect];
            CGContextSaveGState(context);
            [drawPath addClip];
            [img drawInRect: drawRect];
            CGContextRestoreGState(context);
            preBottom = CGRectGetMaxY(drawRect);

        }

    }
    
    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}


+ (UIImage *)drawAutoSizeText:(CGSize) containtSize content:(NSString *)content backgroundColor:(UIColor*)color config:(NSDictionary *)contentConfig isLineBreak:(BOOL)lineBreak
{
    NSAssert(content.length != 0, @"文本不能为空");
    NSAssert(contentConfig, @"需要指定文本属性");

    UIFont * font = [contentConfig objectForKey:NSFontAttributeName];
    if (font == nil) {
        font = FONT(15.0f);
    }
    if (lineBreak) {
        NSAssert(!containtSize.width, @"换行时需要指定contentSize");
        containtSize = [content boundingRectWithSize:containtSize options:0 attributes:contentConfig context:nil].size;
    }
    else
    {
        containtSize = [content boundingRectWithSize:CGSizeMake(kScreenWidth, font.pointSize) options:0 attributes:contentConfig context:nil].size;
    }
    
    UIGraphicsBeginImageContextWithOptions(containtSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (color)
    {
        UIBezierPath* textPath = [UIBezierPath bezierPathWithRect: SizeMakeRect(containtSize)];
        [color setFill];
        [textPath fill];
    }

    CGContextSaveGState(context);
    
    
    CGContextClipToRect(context, SizeMakeRect(containtSize));
    [content drawInRect: SizeMakeRect(containtSize) withAttributes: contentConfig];
    CGContextRestoreGState(context);
    UIImage * returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}


@end
