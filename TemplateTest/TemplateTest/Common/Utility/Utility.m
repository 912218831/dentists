
//
//  Utility.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import <ALView+PureLayout.h>
#import "HWUserLogin.h"
#import "AppDelegate.h"
#import "WXApi.h"
#import <YYImage/YYImage.h>
#import "HWEmptyView.h"

@implementation Utility


/**
 *  获取字符串字数   汉字算两个字 英文算一个字
 *
 *  @param text 传入字符串
 *
 *  @return 返回字符串位数
 */
+ (int)calculateTextLength:(NSString *)text
{
    int strlength = 0;
    char *p = (char *)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i < [text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ; i++)
    {
        if (*p)
        {
            strlength++;
        }
        p++;
        
    }
    return strlength;
}

/**
 *  计算字符串的宽度和高度
 *
 *  @param string 入参的字符串
 *  @param font
 *  @param cSize
 *
 *  @return
 */

+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    /*
     NSStringDrawingTruncatesLastVisibleLine：
     如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
     NSStringDrawingUsesLineFragmentOrigin：
     绘制文本时使用 line fragement origin 而不是 baseline origin。
     The origin specified when drawing the string is the line fragment origin and not the baseline origin.
     NSStringDrawingUsesFontLeading：
     计算行高时使用行距。（译者注：字体大小+行间距=行距）
     NSStringDrawingUsesDeviceMetrics：
     计算布局时使用图元字形（而不是印刷字体）。
     */
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [string boundingRectWithSize:cSize
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attribute
                                       context:nil];
    CGSize retSize = CGSizeMake(round(rect.size.width), round(rect.size.height));
    return retSize;
}

+(CGSize)newCalculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [string boundingRectWithSize:cSize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attribute
                                       context:nil];
    CGSize retSize = CGSizeMake(round(rect.size.width), round(rect.size.height));
    return retSize;
}

/**
 *  计算两点经纬度之间的距离
 *
 *  @param coordinate1 经度
 *  @param coordinate2 纬度
 *
 *  @return 返回距离
 */
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2
{
    
    if (coordinate1.longitude > 0 && coordinate1.longitude < 180)
    {
        if (coordinate2.longitude > 0 && coordinate2.longitude < 180)
        {
            CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:coordinate1.latitude longitude:coordinate2.longitude];
            CLLocation *otherLocation = [[CLLocation alloc]initWithLatitude:coordinate2.latitude longitude:coordinate1.longitude];
            CLLocationDistance distance = [currentLocation distanceFromLocation:otherLocation];
            return distance;
        }
    }
    else
    {
        return 0.00;
    }
    
    return 0.00;
}

/**
 *  角度转弧度
 *
 *  @param angle
 *
 *  @return 返回弧度
 */
+ (CGFloat)convertAngleToArc:(double)angle
{
    if (angle == 0)
    {
        return 0;
    }
    return angle * M_PI / 180.0;
}

/**
 *  弧度转角度
 *
 *  @param arc
 *
 *  @return 返回角度
 */
+ (CGFloat)convertArcToAngle:(double)arc
{
    if (arc == 0)
    {
        return 0;
    }
    return arc * 180.0 / M_PI;
}

/**
 *  校验手机号
 *
 *  @param mobileNum 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    if (mobileNum.length == 11)
    {
        NSString *strFirstNum = [[mobileNum substringFromIndex:0] substringToIndex:1];
        if ([strFirstNum isEqualToString:@"1"])
        {
            return YES;
        }
        return NO;
    }
    else
    {
        return NO;
    }
}


+ (NSString *)formatPhoneNum:(NSString *)phone
{
    NSString *formatStr;
    if ([phone hasPrefix:@"86"])
    {
         formatStr = [phone substringWithRange:NSMakeRange(2, [phone length] - 2)];
         return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        
          formatStr = [phone substringWithRange:NSMakeRange(3, [phone length] - 3)];
         return formatStr;

    }
    else
    {
        return phone;
    }
}
//!!!!: 判断固定电话
/**
 *  判断固定电话
 *
 *  @param phoneNum 手机号码
 *
 *  @return
 */
+ (BOOL)validatePhoneTel:(NSString *)phoneNum
{
    //先判断位数
    if (phoneNum.length == 11 || phoneNum.length == 12 || phoneNum.length == 13)
    {
        NSString *strLine = @"-";
        NSString *str1 = [[phoneNum substringFromIndex:2] substringToIndex:1];
        NSString *str2 = [[phoneNum substringFromIndex:3] substringToIndex:1];
        NSLog(@"str1 = %@\n str2 = %@",str1,str2);
        if ([str1 isEqualToString:strLine] || [str2 isEqualToString:strLine])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

/**
 *  校验密码有效性
 *
 *  @param pwd 密码
 *
 *  @return
 */
+ (BOOL)validatePassword:(NSString *)pwd
{
    if ([pwd isEqualToString:@"112233"] || [pwd isEqualToString:@"123123"] || [pwd isEqualToString:@"123321"] || [pwd isEqualToString:@"123456"] || [pwd isEqualToString:@"654321"] || [pwd isEqualToString:@"abcdef"] || [pwd isEqualToString:@"abcabc"])
    {
        return NO;
    }
    else if (pwd.length == 6)
    {
        NSString *strOne = [[pwd substringFromIndex:0] substringToIndex:1];
        int num = 0;
        for (int i = 0; i < 6; i++)
        {
            NSString *str = [[pwd substringFromIndex:i] substringToIndex:1];
            if ([strOne isEqualToString:str])
            {
                num++;
            }
        }
        if (num >= 6)
        {
            return NO;
        }
    }
    return YES;
}

//!!!!: 隐藏电话号码
/**
 *	@brief	隐藏电话号码
 *
 *	@param 	pNum 	电话号码
 *
 *	@return 186****1325
 */

+ (NSString *)securePhoneNumber:(NSString *)pNum
{
    if (pNum.length != 11)
    {
        return pNum;
    }
    NSString *result = [NSString stringWithFormat:@"%@****%@",[pNum substringToIndex:3],[pNum substringFromIndex:7]];
    return result;
}


/**
 *	@brief	判断是否 全为空格
 *
 *	@param 	string
 *
 *	@return
 */

+ (BOOL)isAllSpaceWithString:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if (![str isEqualToString:@" "])
        {
            return NO;
        }
    }
    return YES;
}

/**
 *	@brief	判断是否 含有空格
 *
 *	@param 	string
 *
 *	@return
 */
+ (BOOL)isOneSpaceWithString:(NSString *)string
{
    if([string rangeOfString:@" "].location != NSNotFound)//_roaldSearchText
    {
        return YES;
    }
    return NO;
    
}

/**
 *	@brief	清除空格
 *
 *	@param 	string
 *
 *	@return
 */
+ (NSString *)clearAwaySpace:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSString *tempStr = [array componentsJoinedByString:@""];
    return tempStr;
}

/**
 *  反转数组
 *
 *  @param targetArray 传入可变数组
 */

+ (void)reverseArray:(NSMutableArray *)targetArray
{
    for (int i = 0; i < targetArray.count / 2.0f; i++)
    {
        [targetArray exchangeObjectAtIndex:i withObjectAtIndex:(targetArray.count - 1 - i)];
    }
}

/**
 *  时间戳转时间
 *
 *  @param strDate 时间戳
 *
 *  @return
 */
+ (NSString *)showDateWithStringDate:(NSString *)strDate
{
    if (strDate.length < 19)
    {
        //确保格式正确，不正确的话，返回后台给的时间
        return strDate;
    }
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *strNow = [formatter stringFromDate:dateNow];
    
    NSString *strToday = [[strNow substringFromIndex:0] substringToIndex:10];
    NSString *strDay = [[strDate substringFromIndex:0] substringToIndex:10];
    if ([strDay isEqualToString:strToday])
    {
        return [[strDate substringFromIndex:11] substringToIndex:5];
        //        return @"今天";
    }
    else
    {
        //判断是否是昨天
        NSDate *dateYesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
        NSString *strYesterday = [formatter stringFromDate:dateYesterday];
        NSString *strYes = [[strYesterday substringFromIndex:0] substringToIndex:10];
        NSString *strYesGet = [[strDate substringFromIndex:0] substringToIndex:10];
        if ([strYes isEqualToString:strYesGet])
        {
            return @"昨天";
        }
        else
        {
            return [[strDate substringFromIndex:0] substringToIndex:10];//显示年月日
            
        }
    }
}


+ (NSString *)showFormatteStringDateWithDate:(NSDate *)date
{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSString * stringDate = @"";
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    stringDate = [formatter stringFromDate:date];
    return stringDate;
    
//    NSTimeInterval time = [date timeIntervalSince1970];
//    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
//    NSTimeInterval timeDistance =nowTime - time;
//    if ((timeDistance / 3600) < 24)
//    {
//        [formatter setDateFormat:@"今天 HH:mm"];
//        stringDate = [formatter stringFromDate:date];
//        
//        return stringDate;
//        
//    }
//    else if ((timeDistance / 3600) > 24 && (timeDistance / 3600) <= 48) {
//        [formatter setDateFormat:@"HH:mm"];
//        stringDate = [formatter stringFromDate:date];
//        
//        return [NSString stringWithFormat:@"昨天 %@",stringDate];
//    }
//    else if((timeDistance / 3600) > 48 && (timeDistance / 3600) <= 72)
//    {
//        [formatter setDateFormat:@"HH:mm"];
//        return [NSString stringWithFormat:@"前天 %@",stringDate];
//        
//        return stringDate;
//        
//    }
//    else
//    {
//        [formatter setDateFormat:@"MM-dd HH:mm"];
//        stringDate = [formatter stringFromDate:date];
//        return stringDate;
//        
//    }
    
}


+ (NSString *)showDateWithString:(NSString *)strDate{
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *strNow = [formatter stringFromDate:dateNow];
    
    NSString *strToday = [[strNow substringFromIndex:0] substringToIndex:10];
    NSString *strDay = [[strDate substringFromIndex:0] substringToIndex:10];
    if ([strDay isEqualToString:strToday])
    {
        return [[strDate substringFromIndex:11] substringToIndex:5];
        //        return @"今天";
    }
    else
    {
        //判断是否是昨天
        NSDate *dateYesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
        NSString *strYesterday = [formatter stringFromDate:dateYesterday];
        NSString *strYes = [[strYesterday substringFromIndex:0] substringToIndex:10];
        NSString *strYesGet = [[strDate substringFromIndex:0] substringToIndex:10];
        if ([strYes isEqualToString:strYesGet])
        {
            return @"昨天";
        }
        else
        {
            return [[strDate substringFromIndex:0] substringToIndex:10];//显示年月日
            
        }
    }

}

/**
 *	@brief	创建navigation title view
 *
 *	@param 	_title 	标题
 *
 *	@return	view
 */
+ (UIView *)navTitleView:(NSString *)title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = BOLDFONT(19);
    lab.textColor = [UIColor blackColor];
    if(title.length > 10){
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:title];
        [mutable replaceCharactersInRange:NSMakeRange(10,title.length - 10) withString:@"..."];
        lab.attributedText = mutable;
    }else{
       lab.text = title;
    }
    return lab;
}

+ (UIView *)navWhiteTitleView:(NSString *)title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = BOLDFONT(19);
    lab.textColor = [UIColor blackColor];
    lab.text = title;
    return lab;
}

/**
 *	@brief	通用navigation 右边按钮 有图片
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 0, 50, 18);
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

//!!!!: 通用navigation 返回按钮
/**
 *	@brief	通用navigation 返回按钮
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navLeftBackBtn:(id)_target action:(SEL)selector
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 22, 40);
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [leftButton addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left_btn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    return left_btn;
}

+ (UIBarButtonItem *)navWalletButton:(id)_target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 0, 60, 44);
    [btn setImage:[UIImage imageNamed:@"topmore"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(13, 20 + 10, 13, 0);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

/**
 *  根据图片生成barbuttonitem
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param image    图片
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 44);
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

/**
 *  根据文字生成barbuttonitem
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param image    图片
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(-100, 0, [Utility calculateStringSize:title font:FONT(15) constrainedSize:CGSizeMake(1000, 44)].width, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(15);
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn sizeToFit];
    [btn setTitleColor:CD_MainColor forState:UIControlStateNormal];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+(UIBarButtonItem *)rightNavigationButton:(id)target action:(SEL)selector title:(NSString *)title font:(UIFont *)font frame:(CGRect)frame{
    
    UIButton *applicationButton = [HWGeneralControl createButtonWithFrame:frame buttonTitleFont:font buttonTitle:title buttonTitleColor:[UIColor whiteColor]];
    applicationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [applicationButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:applicationButton];
  
}

/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showToastWithMessage:(NSString *)message
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:appDel.window];
    [appDel.window addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = -100.0f;
    //    HUD.xOffset = 100.0f;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

/**
 *	@brief	系统提示框
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

/**
 *  风火轮加载信息
 *
 *  @param _targetView 对象
 *  @param _msg        提示信息
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg
{
    
    
    
    [Utility hideMBProgress:_targetView];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    [progressHUD show:YES];
    progressHUD.labelText = _msg;
    [_targetView addSubview:progressHUD];
//    HWEmptyView * backView = [[HWEmptyView alloc] initWithFrame:_targetView.bounds];
//    [_targetView addSubview:backView];
//    backView.backgroundColor = [UIColor clearColor];
//    YYImage * yyImg = [YYImage imageNamed:@"gif-2"];
//    YYAnimatedImageView * animatedImgV = [YYAnimatedImageView newAutoLayoutView];
//    animatedImgV.backgroundColor = [UIColor clearColor];
//    [backView addSubview:animatedImgV];
//    [animatedImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [animatedImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [animatedImgV autoSetDimension:ALDimensionHeight toSize:100];
//    [animatedImgV autoSetDimension:ALDimensionWidth toSize:100];
//    animatedImgV.image = yyImg;

    
}

+ (void)hideMBProgress:(UIView*)_targetView
{
    [MBProgressHUD hideHUDForView:_targetView animated:YES];
//    NSEnumerator *subviewsEnum = [_targetView.subviews reverseObjectEnumerator];
//    for (UIView *subview in subviewsEnum) {
//        if ([subview isKindOfClass:[HWEmptyView class]]) {
//            [subview removeFromSuperview];
//            break;
//        }
//    }

}

/**
 *  根据颜色和尺寸生成图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  获取当前版本
 *
 *  @return
 */
+ (NSString *)getLocalAppVersion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *version = [dict objectForKey:@"CFBundleShortVersionString"];
    return version;
}

//!!!!: 图像保存路径
/**
 *  图像保存路径
 *
 *  @return
 */
+ (NSString *)savedPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return documentsDirectory;
}
/**
 *  获得屏幕图像
 *
 *  @param theView view
 *
 *  @return UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView
{
    //    UIGraphicsBeginImageContext(theView.frame.size);
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//!!!!: 获得某个范围内的屏幕图像
/**
 *  获得某个范围内的屏幕图像
 *
 *  @param theView view
 *  @param r       坐标
 *
 *  @return       UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
    UIRectClip(r);
    UIGraphicsPushContext(context);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//改变label上个别字体颜色的方法
+ (void)changLabelTextColor:(UILabel *)label startLocation:(int)location Range:(int)range color:(UIColor *)color
{
    NSMutableAttributedString * attribuStr = [[NSMutableAttributedString alloc]initWithString:label.text];
    [attribuStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, range)];
    label.attributedText = attribuStr;
    //  现在的label上得字体居中显示的方法
    label.textAlignment = NSTextAlignmentCenter;
    
}

+(void)changeLabelTextAttribute:(UILabel *)label range:(NSRange)range attributes:(NSDictionary *)attribute{

    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc]initWithString:label.text];
    [attributes setAttributes:attribute range:range];
    label.attributedText = attributes;
    
}


/**
 *  将时间戳转换为指定格式时时间
 *
 *  @param strTimestamp  传入的时间戳
 *  @param strDateFormat 时间的格式
 *
 *  @return 返回的时间
 */
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat
{
    if ([strTimestamp isEqualToString:@"0"] || [strTimestamp length] == 0)
    {
        return @"";
    }
    
    
    long long time;
    if (strTimestamp.length == 10) {
        time = [strTimestamp longLongValue];
    }
    else if (strTimestamp.length == 13){
        time = [strTimestamp longLongValue]/1000;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strDateFormat];
    NSString *strTime = [formatter stringFromDate:date];
    return strTime;
}

//!!!!: 通过时间获得时间戳
/**
 *  通过时间获得时间戳     传入时间格式为YYYY-MM-dd HH:mm:ss
 *
 *  @param strDate 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getTimeStampWithDate:(NSString *)strDate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date = [formatter dateFromString:strDate];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    NSString * str  = [NSString stringWithFormat:@"%@000",timeStamp];
    return str;
}

+ (BOOL)isBetweenStarDate:(NSString *)starDate endDate:(NSString *)endDate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [formatter stringFromDate:nowDate];
    NSString *nowStamp = [Utility getTimeStampWithDate:nowStr];
    NSString *starStamp = [Utility getTimeStampWithDate:starDate];
    NSString *endStamp = [Utility getTimeStampWithDate:endDate];
    if ([nowStamp compare:starStamp] == NSOrderedDescending && [nowStamp compare:endStamp] == NSOrderedAscending)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//!!!!: 拼接图片url
/**
 *  拼接图片url
 *
 *  @param url 入参
 *
 *  @return
 */


//!!!!: 千分位格式
/**
 *  千分位格式
 *
 *  @param string 入参
 *
 *  @return
 */
+ (NSString *)conversionThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
    
//        float value = [string floatValue];
//        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
//        [numberFormatter setPositiveFormat:@"###,###;"];
//        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
//        return formattedNumberString;

}
+ (NSString *)conversionFloatThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
}
//!!!!: 判断网络
/**
 *  判断网络
 *
 *  @return
 */
+ (BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
            
        default:
            break;
    }
    
    return isExistenceNetwork;
}

//!!!!: 画底部的线
/**
 *  画底部的线
 *
 *  @param aView
 */
+ (void)bottomLine:(UIView *)aView
{
    UIView *bottomLine = [UIView newAutoLayoutView];
    [aView addSubview:bottomLine];
    [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    //定义颜色之后再换
    bottomLine.backgroundColor = [UIColor blackColor];
}

//!!!!: 画顶部的线
/**
 *  画顶部的线
 *
 *  @param aView
 */
+ (void)topLine:(UIView *)aView;
{
    UIView *topLine = [UIView newAutoLayoutView];
    [aView addSubview:topLine];
    [topLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    topLine.backgroundColor = [UIColor whiteColor];
    [topLine autoSetDimension:ALDimensionHeight toSize:0.5f];
}

//!!!!: 画横线
/**
 *  画线
 *
 *  @param position 传入位置
 *
 *  @return
 */
+ (UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, width, kLineHeight)];
    line.layer.masksToBounds = YES;
    line.clipsToBounds = YES;
    line.image = [Utility imageWithColor:CD_LineColor andSize:(CGSize){width,kLineHeight}];
    return line;
    
}

+ (UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width lineColor:(UIColor *)lineColor
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, width, kLineHeight)];
    line.layer.masksToBounds = YES;
    line.clipsToBounds = YES;
    line.image = [Utility imageWithColor:lineColor andSize:(CGSize){width,kLineHeight}];
    return line;
}

//!!!!: 画竖直线
/**
 *	@brief	画竖直线 方法
 *
 *	@param 	position 	线的位置
 *	@param 	height 	线的高度
 *
 *	@return UIImageView
 */
+ (UIImageView *)drawVerticalLine:(CGPoint)position height:(CGFloat)height
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, kLineHeight, height)];
    line.layer.masksToBounds = true;
    line.image = [self imageWithColor:CD_LineColor andSize:CGSizeMake(1, 1)];
    
    return line;
}

+ (UIImageView *)newDrawLine:(CGPoint)position width:(CGFloat)width
{
    return [self newDrawLine:position width:width color:CD_LineColor];
}

+ (UIImageView *)newDrawLine:(CGPoint)position width:(CGFloat)width color:(UIColor *)color
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, width,0.5)];
    line.backgroundColor = color;
    
    return line;
}

+ (UIImageView *)newDrawBackgroundLineWith:(CGRect)frame
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:frame];
    line.backgroundColor = CD_LineColor;
    
    return line;
    
}

//!!!!: 生成指定大小的图片 图片中心为指定显示的图片
/**
 *  生成指定大小的图片 图片中心为指定显示的图片
 *
 *  @param size      尺寸
 *  @param imageName 图片名字
 *
 *  @return
 */
+ (UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName
{
    if(size.height <= 0 || size.width <= 0)
    {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.center = CGPointMake(CGRectGetWidth(view.frame) / 2.0, CGRectGetHeight(view.frame) / 2.0);
    [view addSubview:imageView];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIGraphicsPushContext(context);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    return image;
}



+ (NSString *)convertCurrencyNumber:(NSNumber *)number
{
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
    numFormat.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *str = [numFormat stringFromNumber:number];
    str = [str stringByReplacingOccurrencesOfString:@"$" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    return str;
}

+ (NSString *)getMoneyNameWithType:(NSString *)type
{
    if ([type isEqualToString:@"enchashment"])
    {
        return @"【提现记录】";
    }
    else if ([type isEqualToString:@"brokerage"])
    {
        return @"【成交佣金】";
    }
    else if ([type isEqualToString:@"parent"])
    {
        return @"【上线奖励】";
    }
    else if ([type isEqualToString:@"war_bank"])
    {
        return @"【权证金融奖励】";
    }
    else
    {
        return @"【其他奖励】";
    }
}

+ (BOOL)isChineseWord:(NSString *)text
{
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] != 3)
        {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isCardNo:(NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,19})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

+ (NSString *)getTimeStampForUnix
{
    NSTimeInterval a = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}


+ (NSString *)moneyEncryptParameter:(NSMutableDictionary *)parameters
{
    NSMutableString *sign = [[NSMutableString alloc] init];
    NSArray *paramArr = [parameters allKeys];
    [paramArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        
        return [str1 compare:str2];
        
    }];
    
    for (int i = 0; i < paramArr.count; i++)
    {
        NSString *key = [paramArr objectAtIndex:i];
        [sign appendFormat:@"%@%@", key, [parameters stringObjectForKey:key]];
    }
        
    [sign appendString:@"F2B4E48EA7BA64578152D5EF3AB0F70FEB0E978F"];
        
    NSString *md5Str = [sign md5:sign];

    NSData *data = [[md5Str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *codeStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return codeStr;
}

+ (NSString *)convertStr:(NSString *)str
{
    
    NSMutableString * temp = [[NSMutableString alloc]init];
    for (int i = 0; i < [str length]; i++) {
        
        UniChar  ch = [str characterAtIndex:i];
        if (ch >= 65 && ch <= 90)
        {
            ch = ch + 32;
            [temp appendFormat:@"%C",ch];
        }
        else if (ch >= 97 && ch <= 122)
        {
            ch = ch - 32;
            [temp appendFormat:@"%C",ch];
        }
        else if ( ch >= 48 && ch <= 57 )
        {
            NSMutableString * tempStr = [NSMutableString stringWithFormat:@"%C",ch];
            int tempInt = [tempStr intValue];
            tempInt += 1;
            tempStr = [NSMutableString stringWithFormat:@"%d",tempInt];
            [temp appendString:tempStr];
        }
        else
        {
            [temp appendFormat:@"%C",ch];
        }
    }
    
    NSString * str1 = [temp substringToIndex:5];
    NSString * str2 = [temp substringFromIndex:5];
    temp = [NSMutableString stringWithFormat:@"%@%@",str2,str1];
    NSLog(@"temp == %@",temp);
    return temp;
}




+ (NSString *)operateDecimal:(NSString *)string
{
    // 保留两位
    CGFloat val = string.doubleValue;
    CGFloat factor = 100;
    CGFloat ret = floor(val * factor + 0.5) / factor;
    return [NSString stringWithFormat:@"%.2f", ret];
}


//画虚线
+ (UIImage *)drawDottedLineColor:(UIColor *)color length:(CGFloat)length isVertical:(BOOL)isVertical
{
    UIImage *image = [[UIImage alloc] init];
    CGSize size = CGSizeZero;
    CGFloat toPointX = 0.0f;
    CGFloat toPointY = 0.0f;
    
    if (isVertical)
    {
        size.width = 1.0f;
        size.height = length;
        toPointX = 0.0f;
        toPointY = length;
    }
    else
    {
        size.width = length;
        size.height = 1.0f;
        toPointX = length;
        toPointY = 0.0f;
    }
    
    UIGraphicsBeginImageContext(size);   //开始画线
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {3,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, toPointX, toPointY);
    CGContextStrokePath(line);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

void alertTwoButton(NSString *title,NSString *message,NSString *btnTitle1,NSString *btnTitle2,id delegate){
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:btnTitle1 otherButtonTitles:btnTitle2,nil];
    [alert show];
    
}

void delayOperation(CGFloat s,void(^block)(void))
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [NSThread sleepForTimeInterval:s];
        dispatch_async(dispatch_get_main_queue(), block);
    });
    
}

+(BOOL)validationPhoneNumber:(NSString *)phoneNumber verifyCode:(NSString *)verifyCode{
    if(phoneNumber.length == 0 ){
        [self showToastWithMessage:@"手机号不能为空"];
        return NO;
    }else if(![self validateMobile:phoneNumber] || phoneNumber.length > 11){
        [self showToastWithMessage:@"手机号格式错误"];
        return NO;
    } else if(verifyCode.length == 0 ){
        [self showToastWithMessage:@"验证码不能为空"];
        return NO;
    }else if(verifyCode.length<6){
        [self showToastWithMessage:@"验证码不对"];
        return NO;
    }
    return YES;
}


+(BOOL)isNilOrNullWithString:(NSString *)str{

    if (str == nil || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@"0"]||[str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (NSData *)convertImgTo200K:(UIImage *)img
{
    return [self convertImgWithImg:img targetLength:200 * 1024];
}

+ (NSData *)convertImgWithImg:(UIImage *)img targetLength:(NSUInteger)targetLength
{
    CGFloat compression = 0.6f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(img, compression);
    while ([imageData length] > targetLength && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(img, compression);
    }
    
    return imageData;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             } else if (ls == 0xfe0f) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (BOOL)isInstalledWX
{
    return [WXApi isWXAppInstalled];
}

+ (UIView *)drawMainColorBlockview
{
    UIView *blockV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7.0f, 19.0f)];
    blockV.backgroundColor = UIColorFromRGB(0xff8522);
    return blockV;
}

+ (UIColor *)randTitleColor {
    static UIColor *col = nil;
    NSArray *totalColorArr = @[UIColorFromRGB(0x41beaa), UIColorFromRGB(0x62aff4), UIColorFromRGB(0xfd7d78), UIColorFromRGB(0xdfbb41), UIColorFromRGB(0xd585ec), UIColorFromRGB(0x41be6d)];//, UIColorFromRGB(0xff9f77), UIColorFromRGB(0x7fbcf5)
    UIColor *randCol =  totalColorArr[arc4random() % totalColorArr.count];
    if ([col isEqual:randCol]) {
        col = [self randTitleColor];
    } else {
        col = randCol;
    }
    return col;
}


#pragma 正则匹配用户身份证号15或18位

+ (BOOL)validateIDCardNumber:(NSString *)value{
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                options:NSRegularExpressionCaseInsensitive
                error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                options:NSRegularExpressionCaseInsensitive
                error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */
+(NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString{
    
    if(jsonString==nil){
        
        return nil;
        
    }
    
    NSData*jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError*err;
    
    NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err){
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

#pragma mark -- 底部弹窗 actionsheet
+ (void)showAlertSheetWithMessage:(NSArray<NSString *> *)contents superView:(UIView *)superView viewController:(id)vc delegate:(id)delegate {
    if (!IOS83) {//
        UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:delegate cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        for (int i=0; i<contents.count; i++) {
            NSString *title = [contents objectAtIndex:i];
            [sheetView addButtonWithTitle:title];
        }
        
        [sheetView showInView:superView]; // 必须调用才能展现出来
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (int i=0; i<contents.count; i++) {
            NSString *title = [contents objectAtIndex:i];
            @weakify(alertController);
            @weakify(vc);
            [alertController addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                @strongify(alertController);
                @strongify(vc);
                NSInteger index = [alertController.actions indexOfObject:action];
                [vc actionSheet:(id)@"" clickedButtonAtIndex:index];
            }]];
        }
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击确认");
            
        }]];
        
        [vc presentViewController:alertController animated:YES completion:nil];
    }
}
//保存字典到文件
+(void)saveSystemDic:(NSDictionary *)dic fileName:(NSString *)fileNameStr
{
    //1. 创建一个plist文件存版本号
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString *filename=[path stringByAppendingPathComponent:fileNameStr];
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager removeItemAtPath:filename error:nil]) {
        NSLog(@"文件删除成功");
    }
    NSFileManager* fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:filename]) //如果不存在
    {
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    //创建一个dic，写到plist文件里
    [dic writeToFile:filename atomically:YES];
}
+(NSDictionary *)getSystemDic:(NSString *)filenameStr
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString *filename=[path stringByAppendingPathComponent:filenameStr];
    //读文件
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSLog(@"dic is:%@",dic2);
    
    return dic2;
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (UIImage *)drawArrowDownImgSize:(CGSize)imageSize color:(UIColor *)color {
    //1.创建图片上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = 1.0f;
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(imageSize.width / 2, imageSize.height - 1.0f)];
    [path addLineToPoint:CGPointMake(imageSize.width, 0)];
    [color setStroke];
    [path stroke];
    //7.从上下文中取出图片
    UIImage *arrowImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //8.卸磨杀驴
    UIGraphicsEndImageContext();
    
    return arrowImage;
}

@end
