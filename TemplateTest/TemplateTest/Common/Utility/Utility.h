//
//  Utility.h
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "HWBaseNavigationController.h"
#import <SDWebImageManager.h>

@class HWProvinceModel;

@interface Utility : NSObject

//计算字符串的字数
+ (int)calculateTextLength:(NSString *)text;

//动态计算字符串高度
+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;
//动态计算字符串高度
+ (CGSize)newCalculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;

//计算两点经纬度之间的距离
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

//角度转弧度
+ (CGFloat)convertAngleToArc:(double)angle;

//弧度转角度
+ (CGFloat)convertArcToAngle:(double)arc;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//去除+86
+ (NSString *)formatPhoneNum:(NSString *)phone;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 判断有效密码
+ (BOOL)validatePassword:(NSString *)pwd;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 判断字符是否全为空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

// 判断字符是否含有空格
+ (BOOL)isOneSpaceWithString:(NSString *)string;

+ (NSString *)clearAwaySpace:(NSString *)string;

// 反转数组
+ (void)reverseArray:(NSMutableArray *)targetArray;

//创建navigation title
+ (UIView *)navTitleView:(NSString *)_title;
+ (UIView *)navWhiteTitleView:(NSString *)_title;

//创建navigation 右按钮是字的
+ (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr;

// 提现
+ (UIBarButtonItem *)navWalletButton:(id)_target action:(SEL)selector;

//创建navigation 右按钮是图片的
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image;

+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector title:(NSString *)title;
+ (UIBarButtonItem *)rightNavigationButton:(id)target action:(SEL)selector title:(NSString *)title font:(UIFont *)font frame:(CGRect)frame;

// 统一返回按钮
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector;

// toast 提示框
+ (void)showToastWithMessage:(NSString *)message;

// alert提示框
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate;

//风火轮加载
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;

//图片的颜色和尺寸
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//图像保存路径
+ (NSString *)savedPath;

//获得屏幕图像
+(UIImage *)imageFromView:(UIView *)theView;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

//改变label上个别字体颜色的方法
+ (void)changLabelTextColor:(UILabel *)label startLocation:(int)location Range:(int)range color:(UIColor *)color;

/**
 *  设置文本中的部分内容
 *
 *  @param label     
 *  @param range     范围
 *  @param attribute 属性
 */
+(void)changeLabelTextAttribute:(UILabel *)label range:(NSRange)range attributes:(NSDictionary *)attribute;

//是否登录
+ (BOOL)isUserLogin;
//是否第三方登录
+ (BOOL)isThirdPartyLogin;

//将时间戳转换为时间
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat;

//将时间转换为时间戳
+ (NSString *)getTimeStampWithDate:(NSString *)strDate;

//判断当前时间是否位于某个时间段
+ (BOOL)isBetweenStarDate:(NSString *)starDate endDate:(NSString *)endDate;

//日期显示规则   本日显示时间，昨日显示“昨日”，之前日期显示具体日期
+ (NSString *)showDateWithStringDate:(NSString *)strDate;
+ (NSString *)showDateWithString:(NSString *)strDate;
// 根据 解析的key 图片链接
+ (NSString *)imageDownloadUrl:(NSString *)url;

//千分位的格式
+ (NSString *)conversionThousandth:(NSString *)string;
//千分位的格式保留两位小数
+ (NSString *)conversionFloatThousandth:(NSString *)string;

//判断网络
+ (BOOL)isConnectionAvailable;

//画底部的线
+ (void)bottomLine:(UIView*)aView;

//画顶部的线
+ (void)topLine:(UIView*)aView;

//画横线
+(UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width;
+ (UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width lineColor:(UIColor *)lineColor;

+ (UIImageView *)newDrawLine:(CGPoint)position width:(CGFloat)width;
+ (UIImageView *)newDrawLine:(CGPoint)position width:(CGFloat)width color:(UIColor *)color;

//画竖直线
+(UIImageView *)drawVerticalLine:(CGPoint)position height:(CGFloat)height;
+ (UIImageView *)newDrawBackgroundLineWith:(CGRect)frame;
//生成指定大小的图片 图片中心为指定显示的图片
+(UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName;

// 设置图片
+ (void)showPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV;
+ (void)showHeadPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV;
+ (void)showPicWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV placeholder:(NSString *)imageName;
+ (void)showPiceLowPriorityWithUrl:(NSString *)urlStr imageView:(UIImageView *)iconImgV;

+ (NSString *)convertCurrencyNumber:(NSNumber *)number;
+ (NSString *)getMoneyNameWithType:(NSString *)type;

+ (BOOL)isChineseWord:(NSString *)text;

+ (BOOL)isCardNo:(NSString *)bankCardNumber;

+ (NSString *)getTimeStampForUnix;

+ (NSString *)societyEncryptParameter:(NSMutableDictionary *)parDict;
+ (NSString *)moneyEncryptParameter:(NSMutableDictionary *)parameters;
+ (NSString *)encryptParameter:(NSDictionary *)dic;

//调登录页面
+ (void)gotoLogin:(BOOL)isGoToBack isForceLogin:(BOOL)isForce;
//绑定调绑定手机页面
+ (void)gotoBindPhone;
//去首页
+(void)gotoFirsrPage;

+ (void)loadingisSuccess;

//判断是否登录成功
+ (void)isUserLoginSuccess:(void(^)())success failure:(void(^)())failure;
//判断是否第三方登录
+ (void)isThirdPartyUserLogin:(void(^)())thirdParty guestlogin:(void(^)())guestlogin;


+ (NSString *)operateDecimal:(NSString *)string;

//根据url设置button背景图片
+ (void)showButtonPicWithUrl:(NSString *)urlStr withButton:(UIButton *)btn;
+ (NSString *)showFormatteStringDateWithDate:(NSDate *)date;
+ (NSURL *)getHeaderIconUrl:(NSString *)url;



/**
 *   弹出UIAlertView,并通过按钮
 *  @param title     title
 *  @param message   提示信息
 *  @param btnTitle1 按钮一
 *  @param btnTitle2 按钮二
 *  @param delegate  代理
 */
extern void alertTwoButton(NSString *title,NSString *message,NSString *btnTitle1,NSString *btnTitle2,id delegate);

/**延迟使用block,s为秒*/
extern void delayOperation(CGFloat s,void(^block)(void));


//画虚线
+ (UIImage *)drawDottedLineColor:(UIColor *)color length:(CGFloat)length isVertical:(BOOL)isVertical;

/**
 *  判断手机号和验证码的格式
 *
 *  @param phoneNumber
 *  @param verifyCode
 *
 *  @return
 */
+(BOOL)validationPhoneNumber:(NSString *)phoneNumber verifyCode:(NSString *)verifyCode;

/**
 *  回到上一级
 */
+(void)popToViewController;

+(BOOL)isNilOrNullWithString:(NSString *)str;

//压缩图片
+ (NSData *)convertImgTo200K:(UIImage *)img;
+ (NSData *)convertImgWithImg:(UIImage *)img targetLength:(NSUInteger)targetLength;


+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (BOOL)isInstalledWX;

//返回首页标题前 主色调颜色块
+ (UIView *)drawMainColorBlockview;

+ (UIColor *)randTitleColor;


/**
 校验身份证的有效性
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */
+(NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString;
/**
 * 底部弹窗
 */
+ (void)showAlertSheetWithMessage:(NSArray<NSString *> *)contents superView:(UIView *)superView viewController:(id)vc delegate:(id)delegate;
/**
 * 纯数字
 */
+ (BOOL)isPureInt:(NSString*)string;
//
/**
 * 保存字典到文件
 */
+(void)saveSystemDic:(NSDictionary *)dic fileName:(NSString *)fileNameStr;
/**
 * 获取字典
 */
+(NSDictionary *)getSystemDic:(NSString *)filenameStr;

/**
 *  画一个向下的尖 >
 */
+ (UIImage *)drawArrowDownImgSize:(CGSize)imageSize color:(UIColor *)color;

/**调整 UIButton 的 image 和 tilte 的位置，实现图片在上，文字在下的效果*/
+ (void)layoutButtonWithImageTopTitleBottom:(UIButton*)btn;
@end
