//
//  NSString+utils.h
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (utils)
//json解析，传入不同的类型
+(NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;
//加密
- (NSString*)sha1;
- (NSString *)md5:(NSString *)str;

// 返回 NSRange 的数组
- (NSArray *)rangesOfString:(NSString *)subStr;
- (NSString *)stringByUrlEncoding;
- (NSString *)decodeFromPercentEscapeString:(NSString *)input;
- (NSString *)appendUrlParam:(NSString *)param;

@end
