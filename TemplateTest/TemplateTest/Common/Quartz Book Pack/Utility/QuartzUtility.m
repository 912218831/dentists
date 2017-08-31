#import "QuartzUtility.h"


#import "QuartzUtility.h"


UIBezierPath * buildTrianglePath(CGSize size,CGFloat lineWidth)
{
    CGFloat originX = 0;
    CGFloat originY = 0;
    if (lineWidth == 1) {
        originX = 0.5;
        originY = 0.5;
    }
    if (lineWidth == 2) {
        originX = 1;
        originY = 2;
        
    }
    if (lineWidth == 3) {
        originX = 1.5;
        originY = 2.5;
        
    }
    
    if (lineWidth == 4) {
        originX = 1;
        originY = 3;
        
    }
    if (lineWidth == 5) {
        originX = 1.5;
        originY = 3.5;
        
    }
    if (lineWidth == 6) {
        originX = 2;
        originY = 4;
    }
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = lineWidth;
    [path moveToPoint:CGPointMake(originX, size.height + originY)];
    [path addLineToPoint:CGPointMake(size.width/2+originX, originY)];
    [path addLineToPoint:CGPointMake(size.width+originX, size.height + originY)];
    return path;
}


UIBezierPath * buildDoubleArrowPath(CGSize size,CGFloat lineWidth)
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath * topArrow = buildTrianglePath(CGSizeMake(size.width, size.height/2), lineWidth);
    UIBezierPath * bottomArrow = [topArrow safeCopy];
    MovePathCenterToPoint(bottomArrow, CGPointMake(PathCenter(topArrow).x, PathCenter(topArrow).y+size.height/2));
    [path appendPath:topArrow];
    [path appendPath:bottomArrow];
    return path;

}

UIBezierPath * buildCircle(CGRect bounds)
{

    return [UIBezierPath bezierPathWithOvalInRect: bounds];
}

UIBezierPath * bulildRectPath(CGSize size)
{
    return [UIBezierPath bezierPathWithRect:SizeMakeRect(size)];
}

UIColor *NoiseColor()
{
    static UIImage *noise = nil;
    if (noise)
        return [UIColor colorWithPatternImage:noise];
    
    srandom(time(0));
    
    CGSize size = CGSizeMake(128, 128);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    for (int j = 0; j < size.height; j++)
        for (int i = 0; i < size.height; i++)
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(i, j, 1, 1)];
            CGFloat level = ((double) random() / (double) LONG_MAX);
            [path fill:[UIColor colorWithWhite:level alpha:1]];
        }
    noise = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:noise];
}

