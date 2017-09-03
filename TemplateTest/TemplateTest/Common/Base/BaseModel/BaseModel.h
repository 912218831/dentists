//
//  BaseModel.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//
/// Mat

#import <MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface BaseModel : MTLModel <MTLJSONSerializing>

/// 模型转为 JSON 数据
- (NSDictionary *)JSONDictionaryFromModel;

@end
