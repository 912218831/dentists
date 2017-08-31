//
//  HWFileManger.h
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/5/8.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWFileManger : NSObject

+ (BOOL)createDocumentSubPath:(NSString *)path;
+ (BOOL)writeToDocumentPath:(NSString *)path contentData:(NSData *)data;
+(NSData *)readDataAtDocumentPath:(NSString *)path;
@end
