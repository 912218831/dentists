//
//  ViewControllerSimpleConfig.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerSimpleConfig : NSProxy

/// 配置视图控制器上基本属性元素
+ (NSDictionary *)viewModelSimpleConfigMappings:(id)viewModel;

@end
