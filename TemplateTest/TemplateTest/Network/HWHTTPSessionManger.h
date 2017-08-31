//
//  HWHTTPSessionManger.h
//  TemplateTest
//
//  Created by 杨庆龙 on 16/5/5.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HWHTTPSessionManger : AFHTTPSessionManager

+ (instancetype)shareHttpClient;

- (NSURLSessionDataTask *)HWGet:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(id))success
                        failure:(void (^)(NSString *code, NSString *error))failure;

- (NSURLSessionDataTask *)HWPOST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(id responese))success
                         failure:(void (^)(NSString *code, NSString *error))failure;
- (NSURLSessionTask *)HWPOSTImage:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure;
@end
