//
//  HWRequestConfig.h
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#ifndef Template_OC_HWRequestConfig_h
#define Template_OC_HWRequestConfig_h


#define kPageCount                      10                   //每页请求数据数
#define kFirstPage                      1                   // 默认第一页

#define kNetworkFailedMessage           @"网络不给力,请稍后再试!"

#define kStatusLogout                   -99
#define kStatusSuccess                  0
#define kStatusNetworkFailed            404


#define kUrlBase                    @"http://116.62.202.152/api/mouth/den/index.php/"

#define kHtmlBase                   @"http://116.62.202.152/api/mouth/app-web/kq_pro_doc/app"

//请求域名接口
#define kGetDomain                  @"index/getCustomerDomain.do"

#define kLogin                      @"Account/DoLogin"//登录
#define kRegister                   @"Account/DoRegister"//注册
#define kGetVerifyCode              @"Account/DoSendSms"//获取验证码
#define kModifyPassword             @"Member/DoUpMember" //修改密码
#define kSupplementInfo             @"Member/DoUpMember"//完善账号信息
//H5链接

#define AppendHTML(shortUrl)   [NSString stringWithFormat:@"%@%@?userKey=%@",kHtmlBase,shortUrl,[HWUserLogin currentUserLogin].userkey]

#define kAskHTML                     @"/my/answer.html" // 问答
#define kReserverListHTML            @"/my/patient-list.html" // 预约列表
#define kReserverDetailHTML          @"/my/patient-detail.html" // 预约详情

#define kLoginGainVertifyCode        @"acc/getVerifyCode" //获取验证码
#define kLoginApp                    @"acc/loginByCode" //登录
#define kHomePageInformation         @"main/loadMainPageInfo" //首页数据

#define kReserverRecordList          @"" // 预约记录列表
#define kReserverRecordSearch        @"" // 预约记录搜索
#define kReserverRecordDetail        @"" // 预约病人详情

#define kPersonCenterInfo            @"acc/getUserInfo" // 设置--
#define kPersonCenterLogout          @"acc/logout" // 设置--退出登录
#define kPersonCenterChangePwd       @"" // 设置--设置密码
#define kPersonCenterGainVertifyCode kLoginGainVertifyCode // 设置--设置密码--获取验证码
#endif



