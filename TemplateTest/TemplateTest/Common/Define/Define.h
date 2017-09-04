//
//  Define.h
//  Template-OC
//
//  Created by niedi on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#ifndef Template_OC_Define_h
#define Template_OC_Define_h

typedef enum{
    
    LogicLine_GetMoney = 1, // 点击提现-->提示绑定-->提示设置提现密码-->设置提现密码-->绑定银行卡-->提现
    LogicLine_BindCard = 2,  // 点击绑定银行卡-->提示验证提现密码-->验证-->绑定银行卡
    LoginLine_UnBindCard = 3,  // 解绑银行卡
    LogicLine_PwdManager = 4,     // 点击提现密码 --> 是否设置 --> 进入管理
    LogicLine_PayMoney = 5
    
}LogicLine;

typedef enum{
    
    Modify_First_OldPassword = 0,
    Modify_Second_NewPassword,
    Modify_Third_NewPassword,
    Forgot_First_NewPassword,
    Forgot_Second_NewPassword,
    Confirm_Password,
    pay_Password
    
    
}PasswordMode;

typedef enum
{
    NewHouse = 0,
    SecondHouse
}HouseType;

typedef enum
{
    priceTrend = 0, //成交均价
    numberTrend      //月成交套
}TrendType;


typedef enum 
{
    tagScreen = 0,      /**<  标签搜索 */

    mantTagsScreen,     /**<  多标签搜索 */

    keyWordScreen,      /**<  关键字搜索 */

    noCoditionScreen,   /**<  没有搜索条列表 */

    tabbarSource,       /**<  tabbar过来 */

    collectetionSource  /**<  从收藏页面过来的 */

}HWScreenType;


typedef enum
{
    lowerThanAverage = 0,   //低于成交价
    mostOfDone,             // 成交最多
    mostOfRecommend         //推荐最多
}NewHouseListType;

#define MYLog(...) \
    rac_keywordify \
    NSLog(@"%@,\n%s:%d\n",__VA_ARGS__,__FUNCTION__,__LINE__);
/*
 　1) __VA_ARGS__   是一个可变参数的宏，这个可宏是新的C99规范中新增的，目前似乎gcc和VC6.0之后的都支持（VC6.0的编译器不支持）。宏前面加上##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的","去掉的作用。
 　　2) __FILE__    宏在预编译时会替换成当前的源文件名
 　　3) __LINE__   宏在预编译时会替换成当前的行号
 　　4) __FUNCTION__   宏在预编译时会替换成当前的函数名称
 */
#define mainThreadQueue(...) \
    autoreleasepool {\
        if ([NSThread isMainThread]) {__VA_ARGS__} else {\
        dispatch_sync(dispatch_get_main_queue(), ^{__VA_ARGS__});\
    }}

#define isKindClass(A, B) \
    ({ \
        BOOL result = NO; \
        if ([A isKindOfClass:objc_getClass(B)]) {\
        result = YES;\
        } else { result = NO; }\
        result;      \
    });

#define isSubClass(A, B) \
        isKindClass(class_getSuperclass([A class]), B);

#define weakUserLogin ({__weak HWUserLogin *userLogin  = [HWUserLogin currentUserLogin]; userLogin;})

/*
 AppDelegate
 */
#define SHARED_APP_DELEGATE             ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define SET_USERDEFAULT(value,key)\
[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];\

#define GET_USERDEFAULT(key)     [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define REMOVE_USERDEFAULT(key)\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];\

/*  UIColor
 */
#define UIColorFromRGB(rgbValue)	    UIColorFromRGBA(rgbValue,1.0)

#define UIColorFromRGBA(rgbValue,a)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


/*  DocumentPath
 */
#define DocumentPath                    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


/*  iOS版本
 */
#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0 ? YES : NO)
#define IOS7Later                       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS7Dot0                        ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define IOS8                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define IOS83                           ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3 ? YES : NO)
#define IOS10                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? YES : NO)


/*  屏幕尺寸
 */
#define IPHONE4                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


/*  设备方向
 */
#define Portrait            ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait ? YES : NO)
#define PortraitUpsideDown  ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown ? YES : NO)
#define LandscapeLeft       ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ? YES : NO)
#define LandscapeRight      ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight ? YES : NO)


/*  宽高
 */
#define CONTENT_HEIGHT                  ([UIScreen mainScreen].bounds.size.height - 64)
#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define KScreenContent                  ([UIScreen mainScreen].bounds.size.width - 30.0f)

#define kx3Rate                              (IPHONE6PLUS ? 1.5 : 1)
#define kLineHeight                          (1.0f / [[UIScreen mainScreen] scale])
#define KLeftSpaceWidth                 15.0f

//MYP add v3.0引导页适配用
#define kRate320 [UIScreen mainScreen].bounds.size.width/320

#define maxSpace                             5.0f           //collectionview中cell间的间隙
/*  较iPhone4屏宽比例
 */
#define kScreenRate                     ([UIScreen mainScreen].bounds.size.width / 375.0f)
#define kRate(value)                    (value*kScreenRate)
#define kRateLength(length)             (([UIScreen mainScreen].bounds.size.width / 375.0f) * (length))

#define BrandHallCellHeight 100   //MYP add 品牌馆cell高度

/*  颜色
 CD For Color Define
 */

#define CD_Text                         UIColorFromRGB(0x0a0b0b)
#define CD_Text33                       UIColorFromRGB(0x333333)
#define CD_Text99                       UIColorFromRGB(0x999999)
#define CD_Textb6                       UIColorFromRGB(0xb6b6b6)
#define CD_Textd8                       UIColorFromRGB(0xd8d8d8)
#define CD_Textcc                       UIColorFromRGB(0xcccccc)
#define LightGray                       UIColorFromRGB(0xcac9cf)   //浅灰
#define CD_Border                       UIColorFromRGB(0xffbc90)
//MYP add 字体颜色
#define CD_TextBlack                    UIColorFromRGB(0x000000)//黑色
#define CD_Text66                       UIColorFromRGB(0x666666)//深灰
#define CD_yellow                       UIColorFromRGB(0xFcE39D)//黄色

//色调
#define CD_MainColor                    UIColorFromRGB(0x28beff)//主色调
#define CD_LineColor                    UIColorFromRGB(0xdedede)//线条颜色,画线
#define CD_LIGHT_BACKGROUND             UIColorFromRGB(0xf9f9f9)//浅背景色

#define CD_GreenLine                    UIColorFromRGB(0x1DB193)//行情绿色折线
#define CD_OrangeLine                   UIColorFromRGB(0xffe2ce)//浅黄色 线
#define CD_OrangeBtn                    UIColorFromRGB(0xfe9650)//浅黄色 发送验证码按钮
#define CD_MoreColor                    UIColorFromRGB(0x8A9AB2)//查看更多

//辅色
#define CD_Red                          UIColorFromRGB(0xea524d)//红色
#define CD_Red1                         UIColorFromRGB(0xeb632e)//红色
#define CD_Orange                       UIColorFromRGB(0xFC973A)//橙色
#define CD_Green                        UIColorFromRGB(0x2fc8ad)//绿色
#define CD_Blue                         UIColorFromRGB(0x4eb6cf)//蓝色
#define CD_Purple                       UIColorFromRGB(0xbd8dd3)//紫色
#define CD_SelectedText                 UIColorFromRGB(0xff6600)
#define CD_TagColor                     UIColorFromRGB(0xcccccc) //标签的颜色
#define CD_OrderMangerCellBg            UIColorFromRGB(0xf8f8f8)

#define COLOR_000000                    UIColorFromRGB(0x000000)
#define COLOR_0ABE99                    UIColorFromRGB(0x0ABE99)
#define COLOR_21A754                    UIColorFromRGB(0x21A754)
#define COLOR_2967AF                    UIColorFromRGB(0x2967af)
#define COLOR_333333                    UIColorFromRGB(0x333333)
#define COLOR_4FB3DE                    UIColorFromRGB(0x4FB3DE)
#define COLOR_5ED4BC                    UIColorFromRGB(0x5ED4BC)
#define COLOR_80C8E7                    UIColorFromRGB(0x80c8e7)
#define COLOR_666666                    UIColorFromRGB(0x666666)
#define COLOR_999999                    UIColorFromRGB(0x999999)
#define COLOR_C98FE4                    UIColorFromRGB(0xC98FE4)
#define COLOR_CCCCCC                    UIColorFromRGB(0xCCCCCC)
#define COLOR_DEDEDE                    UIColorFromRGB(0xDEDEDE)
#define COLOR_DEBAEE                    UIColorFromRGB(0xDEBAEE)
#define COLOR_E0E0E0                    UIColorFromRGB(0xE0E0E0)
#define COLOR_EAEAEA                    UIColorFromRGB(0xEAEAEA)
#define COLOR_EC7E33                    UIColorFromRGB(0xEC7E33)
#define COLOR_EFEFEF                    UIColorFromRGB(0xEFEFEF)
#define COLOR_F0512B                    UIColorFromRGB(0xF0512B)
#define COLOR_F3F3F3                    UIColorFromRGB(0xF3F3F3)
#define COLOR_F2F2F2                    UIColorFromRGB(0xF2F2F2)
#define COLOR_F5F5F5                    UIColorFromRGB(0xF5F5F5)
#define COLOR_F8DFB9                    UIColorFromRGB(0xF8DFB9)
#define COLOR_F8DDB6                    UIColorFromRGB(0xF8DDB6)
#define COLOR_F9CA99                    UIColorFromRGB(0xF9CA99)
#define COLOR_FF0000                    UIColorFromRGB(0xFF0000)
#define COLOR_FF6600                    UIColorFromRGB(0xFF6600)
#define COLOR_FF7215                    UIColorFromRGB(0xFF7215)
#define COLOR_FFAA70                    UIColorFromRGB(0xFFAA70)
#define COLOR_FFAD0E                    UIColorFromRGB(0xFFAD0E)
#define COLOR_FFC350                    UIColorFromRGB(0xFFC350)
#define COLOR_FFE325                    UIColorFromRGB(0xFFE325)
#define COLOR_FFFFFF                    UIColorFromRGB(0xFFFFFF)
#define COLOR_F9FAFA                    UIColorFromRGB(0xF9FAFA)

/*  字体
 TF For Text Font
 */
#define FONTNAME                        @"Helvetica Neue"
#define Font_Number                     @"Helvetica Neue LT Pro"
#define FONT(fontSize)                  [UIFont systemFontOfSize:fontSize]

#define BOLDFONTNAME                    @"Helvetica-Bold"
#define BOLDFONT(fontSize)              [UIFont boldSystemFontOfSize:fontSize]

#define TF13                            13.0f
#define TF15                            15.0f
#define TF19                            19.0f
#define TF20                            20.0f
#define TF24                            24.0f
#define TF26                            26.0f
#define TF30                            30.0f

/*  存储命名
 UD For userdefaults
 */
#define UDFirstLanunch                  @"isFirstLaunch"          // 首次启动  (首页弹出广告用到)
#define kLaunchAdvert                   @"launchAdvert"             //启动页广告
#define kLaunchAdvertStatus             @"kLaunchAdvertStatus"   //启动页广告结束标志

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define  HWRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

/*  定义
 DF For Define
 */
#define ABOUT_US                        [NSString stringWithFormat:@"%@/hwapp/help/aboutUs", kPHPUrlBase] // ios14.haowu.com
#define SHARE_SECONDE                   [NSString stringWithFormat:@"%@/hwapp/house/secondHandHouseItem", kPHPUrlBase] //ios14.haowu.com
#define ITUNSE_DOWNLOAD                 @"http://m.haowu.com/app/"
#define LOADING_TEXT                    @"加载中"
#define LOADINGFAIL                     @"加载失败\n点击屏幕重新加载"
#define storyboard(name)                [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:name]
#define HWPROTOCOL                      [NSString stringWithFormat:@"%@/hwapp/help/userProtocol", kPHPUrlBase]   // ios14.haowu.com/hwapp/help/userProtocol
#define APP_ID                          @"1018136206"


#define App_Version                     @"16"     // 强制更新版本号6.5.0 是18
#define KCurrentGuideVersionStr         @"guideVersion_6.0"


/*  通知
 NT For Notification
 */
#define NTPAY_SUCCESS                           @"pay_success"
#define kremoveAll                              @"kremoveAll"
#define kLocationSuccessNotification            @"kLocationSuccessNotification"
#define kLocationFailNotification               @"kLocationFailNotification"
#define kLaunchAdvertFinshed                    @"kLaunchAdvertFinshed"
#define kSubmitNeedSuccess                      @"SubmitNeedSuccess" //购房需求成功
#define kChangeLoactionName                     @"kChangeLoactionName"//定位成功后弹框
#define kCollectionSuccess                      @"collectionSuccess"//收藏成功

/*
 各种key值
 */

//友盟key

#define UMAPPKEY  @"559f329267e58e6bcd001fb9"

//TalkingData Key
#define TalkingDataKey @"D364781D141CB356C1C029A992AD572B"

//高德
#define GaoDeKey                    @"2f6c2a9e812df3fe859dbf1653b92134"         // 高德key
//#define GaoDeKey                     @"72420ec10c2f5c3335b63365b9bbda78"//测试

#define GaoDeWebKey                 @"cc337f439aca8572dc24db2b99a92ca0"     //在生成静态地图坐标时用到


#define kChangeCityNotification                 @"ChangeCityNotification"
#define kReleaseHouseSuccess                    @"ReleaseHouseSuccess"
#define kLoginSuccessFreshNotification          @"kLoginSuccessFreshNotification"          //登陆成功后刷新数据
#define kQuitLoginNotification                  @"kQuitLoginNotification"             //退出登录


#define kPhone4Length(length)           ([UIScreen mainScreen].bounds.size.width / 320.0f) * length
#define kPhone6Length(length)           ([UIScreen mainScreen].bounds.size.height / 667.0f) * length
#define kPhone6WidthLength(length)      ([UIScreen mainScreen].bounds.size.width / 375.0f) * length

/*ViewModel 所有的类名*/
#define kHomePageVM       @"HomePageViewModel"
#define kLoginVM          @"LoginViewModel"
#define kReserverRecordVM @"ReserverRecordViewModel"

#endif

