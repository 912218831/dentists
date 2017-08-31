//
//  HWHTTPSessionManger.m
//  TemplateTest
//
//  Created by 杨庆龙 on 16/5/5.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import "HWHTTPSessionManger.h"
#import <YYCategories/YYCategories.h>
typedef void(^QuerySuccess)(id);
typedef void(^QueryFail)(NSString *code, NSString *error);

@interface HWHTTPSessionManger()

@property(nonatomic,strong)QuerySuccess querySuccess;

@property(nonatomic,strong)QueryFail queryFail;

@property(nonatomic,strong,readwrite)NSURL* baseURL;

@end

@implementation HWHTTPSessionManger

+ (instancetype)shareHttpClient
{
    static HWHTTPSessionManger * _manager = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        _manager = [[HWHTTPSessionManger alloc] init];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
    });
    return _manager;
}


+ (instancetype)manager
{
    [HWHTTPSessionManger shareHttpClient].baseURL = [NSURL URLWithString:kUrlBase];
    return [HWHTTPSessionManger shareHttpClient];

}

- (NSString *)encryptParameter:(NSMutableDictionary *)parDict
{
    NSMutableString *sign = [NSMutableString string];
    NSArray* arr = [parDict allKeys];
    NSMutableSet *mutArr = [NSMutableSet set];
    for (int i = 0; i < arr.count; i++) {
        NSString *key = [arr objectAtIndex:i];
        NSString *value = [parDict stringObjectForKey:key];
        
        
        [mutArr addObject:key];
        [mutArr addObject:value];
    }
    
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    NSArray *sortArr = [mutArr sortedArrayUsingDescriptors:sortDesc];
    
    
    for (int i = 0 ; i < sortArr.count ; i++)
    {
        [sign appendFormat:@"%@", [sortArr objectAtIndex:i]];
    }
    [sign appendString:@"999a7a5593324cdb889d9d679d1c5745"];
    
    
    NSString *str = [sign md5:(NSString *)sign];
    NSData *data = [[str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *codestr = [data base64EncodedString];
    
    return codestr;
}


- (void)handleResponse:(id)response
{
    NSDictionary * dict = nil;
    if ([response isKindOfClass:[NSDictionary class]]) {
        dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)response];
    }
    if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
    {
        if(self.querySuccess)
            self.querySuccess(dict);
    }
    else
    {
        if(self.queryFail)
        {
            if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
            {
                //  未登录
                [Utility isThirdPartyUserLogin:^{
                    [Utility gotoBindPhone];
                } guestlogin:^{
                    [Utility gotoLogin:YES isForceLogin:YES];
                }];
            }
            else
            {
                if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                {
                    self.queryFail([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                }
                else
                {
                    self.queryFail([dict stringObjectForKey:@"status"], kNetworkFailedMessage);
                }
            }
            
        }
    }

}


- (NSURLSessionDataTask *)HWGet:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(id))success
                        failure:(void (^)(NSString *code, NSString *error))failure
{

    return [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            self.querySuccess = [success copy];
        }
        if (failure) {
            self.queryFail = [failure copy];
        }
        [self handleResponse:dict];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkFailed], kNetworkFailedMessage);

    }];
}


- (NSURLSessionDataTask *)HWPOST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSString *, NSString *))failure
{
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:[HWUserLogin currentUserLogin].userkey forKey:@"userkey"];
    [parDict setPObject:@"ios" forKey:@"os"];
    [self.requestSerializer setTimeoutInterval:15.0f];

   return [self POST:URLString parameters:parDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
       if (success) {
           self.querySuccess = [success copy];
       }
       if (failure) {
           self.queryFail = [failure copy];
       }
       [self handleResponse:responseObject];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkFailed], kNetworkFailedMessage);

    }];
}

- (NSURLSessionTask *)HWPOSTImage:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure
{

   return  [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       for (NSString *dictKey in [parameters allKeys])
       {
           if ([dictKey isEqualToString:@"pubFile"] || [dictKey isEqualToString:@"file"])
           {
               NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
               NSString *documentsDirectory = [paths objectAtIndex:0];
               
               NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
               NSData *imageData = [parameters objectForKey:dictKey];
               
               [imageData writeToFile:savedImagePath atomically:YES];
               [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
               
               
           }
       }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            self.querySuccess = [success copy];
        }
        if (failure) {
            self.queryFail = [failure copy];
        }
        [self handleResponse:responseObject];
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure(error.localizedDescription);

        
    }];
}


- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler
{
    NSMutableURLRequest *modifiedRequest = request.mutableCopy;
    AFNetworkReachabilityManager *reachability = self.reachabilityManager;
    if (!reachability.isReachable)
    {
        modifiedRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    return [super dataTaskWithRequest:modifiedRequest completionHandler:completionHandler];
    
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler
{
    NSURLResponse *response = proposedResponse.response;
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse*)response;
    NSDictionary *headers = HTTPResponse.allHeaderFields;
    if (headers[@"Cache-Control"])
    {
        NSMutableDictionary *modifiedHeaders = headers.mutableCopy;
        modifiedHeaders[@"Cache-Control"] = @"max-age=60";
        NSHTTPURLResponse *modifiedHTTPResponse = [[NSHTTPURLResponse alloc]
                                                   initWithURL:HTTPResponse.URL                                                   statusCode:HTTPResponse.statusCode                                                   HTTPVersion:@"HTTP/1.1"                                                   headerFields:modifiedHeaders];
        proposedResponse = [[NSCachedURLResponse alloc] initWithResponse:modifiedHTTPResponse                                                                    data:proposedResponse.data                                                                userInfo:proposedResponse.userInfo                                                           storagePolicy:proposedResponse.storagePolicy];
    }

    [super URLSession:session dataTask:dataTask willCacheResponse:proposedResponse completionHandler:completionHandler];
    

}

@end
