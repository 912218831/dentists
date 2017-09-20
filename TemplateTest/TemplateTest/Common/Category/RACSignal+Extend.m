//
//  RACSignal+Extend.m
//  TemplateTest
//
//  Created by HW on 17/9/14.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "RACSignal+Extend.h"

@implementation RACSignal (Extend)

- (VirtualSignal *)newSwitchToLatest {
    return [VirtualSignal createSignal:^(id<RACSubscriber> subscriber) {
        [self subscribeNext:^(RACSignal *x) {
            [x subscribe:subscriber];
        }];
    }];
}

@end
