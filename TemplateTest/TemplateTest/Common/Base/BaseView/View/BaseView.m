//
//  BaseView.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView
- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
        [self layoutSubViews];
        [self initDefaultConfigs];
    }
    return self;
}
- (void)initSubViews {}

- (void)layoutSubViews {}

- (void)initDefaultConfigs {}
@end
