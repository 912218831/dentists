//
//  RACSignal+Extend.h
//  TemplateTest
//
//  Created by HW on 17/9/14.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VirtualSignal.h"

#define RACTupleArray(value)  [RACTuple tupleWithObjectsFromArray:value]

@interface RACSignal (Extend)
- (VirtualSignal *)newSwitchToLatest;
@end
