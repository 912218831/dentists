//
//  HWShareManager.m
//  SwiftTest
//
//  Created by caijingpeng.haowu on 15/2/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：分享渠道管理类 ， 项目所有分享功能均使用此类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

#import "HWShareManager.h"

#define DEFAULTSHARECONTENT         @"买房上好屋，朋友买房推荐上好屋"

@implementation HWShareManager

+ (void)shareMessageToWeiBoWithURL:(NSString *)urlStr
             socialUrlResourceType:(UMSocialUrlResourceType)socialUrlResourceType
                           content:(NSString *)content
                             image:(UIImage *)image
               presentedController:(UIViewController *)presentController
                        completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
//    [UMSocialData defaultData].urlResource.url = urlStr;
//    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = urlStr;
//    [UMSocialData defaultData].extConfig.sinaData.urlResource.resourceType = socialUrlResourceType;
//    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:content image:image location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response) {
//        if (completion) {
//            completion(response);
//        }
//        
//    }];
    
    [[UMSocialControllerService defaultControllerService] setShareText:content shareImage:image socialUIDelegate:presentController];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(presentController,[UMSocialControllerService defaultControllerService],YES);
    
}

//微信分享
+ (void)shareMessageToWeiXinWIthURL:(NSString *)urlStrl
                SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                              title:(NSString *)title
                            content:(NSString *)content
                              image:(id)image
                presentedController:(UIViewController *)presentedController
                         completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].extConfig.wxMessageType = SocialWXMessageType;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStrl;
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialData defaultData].urlResource.url = urlStrl;
    
    
    [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToWechatSession] content:content image:image location:nil urlResource:nil presentedController:presentedController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             if (completion)
             {
                 completion(response);
             }
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败"];
         }
     }];
}

//分享到微信朋友圈

+ (void)shareMessageToWeixinFriendsWithURL:(NSString *)urlStr
                       SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                                   content:(NSString *)content title:(NSString *)title
                                     image:(id)image
                         presentController:(UIViewController *)presentController
                                completion:(void (^)(UMSocialResponseEntity *))completion
{

    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].extConfig.wxMessageType = SocialWXMessageType;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:image location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             if (completion)
             {
                 completion(response);
             }
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败"];
         }
     }];

}

+ (void)shareMessageToWeixinFriendsWithURL:(NSString *)urlStr
                       SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                                   content:(NSString *)content
                                     image:(id)image
                         presentController:(UIViewController *)presentController
                                completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].extConfig.wxMessageType = SocialWXMessageType;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
    [UMSocialData defaultData].urlResource.url = urlStr;
    [UMSocialData defaultData].extConfig.title = content;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:image location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             if (completion)
             {
                 completion(response);
             }
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败"];
         }
     }];
}

+ (void)shareMessageToQZoneWithURL:(NSString *)urlStr
               SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                             title:(NSString *)titleStr
                           content:(NSString *)content
                             image:(id)image
                 presentController:(UIViewController *)presentController
                        completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    titleStr = titleStr.length > 0 ? titleStr : DEFAULTSHARECONTENT;
    
    [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
    [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = content;
    [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(image, 0.1f);
    //分享数据，平台设置   UMSocialQzoneData
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:content image:nil location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             if (completion)
             {
                 completion(response);
             }
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败"];
         }
     }];
}

@end
