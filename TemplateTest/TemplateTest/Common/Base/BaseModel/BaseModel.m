//
//  BaseModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

- (NSDictionary *)JSONDictionaryFromModel {
    return [MTLJSONAdapter JSONDictionaryFromModel:self error:nil];
}

@end
