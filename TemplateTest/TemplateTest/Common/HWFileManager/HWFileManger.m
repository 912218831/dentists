//
//  HWFileManger.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/5/8.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWFileManger.h"

@implementation HWFileManger

+ (BOOL)createDocumentSubPath:(NSString *)path
{
    BOOL createSuccess = YES;
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSArray * paths = [path componentsSeparatedByString:@"/"];
    NSString * subPath = documentPath;
    for (NSInteger index = 0; index < paths.count; index++)
    {
        NSString * subPathName = [paths objectAtIndex:index];
        subPath = [subPath stringByAppendingPathComponent:subPathName];
        if (index != paths.count - 1)
        {
            createSuccess = [fileManger createDirectoryAtPath:subPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        else
        {
            createSuccess = [fileManger createFileAtPath:subPath contents:nil attributes:nil];
        }
    }
    return createSuccess;
}

+ (BOOL)writeToDocumentPath:(NSString *)path contentData:(NSData *)data
{
    BOOL writeSuccess;
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [self removePrefix:path];
    NSString * subPath = [documentPath stringByAppendingPathComponent:path];
    if (![fileManger fileExistsAtPath:subPath]) {
        [self createDocumentSubPath:path];

    }
    writeSuccess = [data writeToFile:subPath atomically:YES];
    return writeSuccess;
    
}

+ (NSString *)removePrefix:(NSString *)str
{
    if (str.length > 0 && [str hasPrefix:@"/"]) {
        NSMutableString * multableStr = [NSMutableString stringWithString:str];
        [multableStr deleteCharactersInRange:NSMakeRange(0, 1)];
        return [self removePrefix:[multableStr copy]];
    }
    else
    {
        return str;
    }

}

+(NSData *)readDataAtDocumentPath:(NSString *)path
{
    NSData * data = [NSData data];
    
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [self removePrefix:path];
    NSString * subPath = [documentPath stringByAppendingPathComponent:path];
    data = [NSData dataWithContentsOfFile:subPath options:NSDataReadingUncached error:nil];
    return data;
}


@end
