//
//  ViewControllersRouter.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllersRouter : NSObject<NavigationProtocol>

+ (instancetype)shareInstance;

- (Class )classNameForViewModel:(NSString *)viewModelName;

- (Class)classNameForDataSource:(NSString *)dataSourceName;

- (Class)classNameForListView:(NSString *)listViewName;

- (UIViewController *)controllerMatchViewModel:(BaseViewModel *)viewModel;

- (void)setRootViewController:(NSString *)viewModelName;
/// 程序启动式，来设置 根视图
- (void)luanchRootViewController;

@end
