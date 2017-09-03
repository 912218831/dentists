//
//  BaseViewController.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWBaseViewController.h"
#import "BaseViewModel.h"
#import "ViewControllerSimpleConfig.h"

@interface BaseViewController : HWBaseViewController

@property (nonatomic, strong, readonly)  UIView         *contentView;
@property (nonatomic, strong, readwrite) BaseViewModel *viewModel;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

#warning 这里最好绑定一个 viewModel 以便于，后面的正常运行;
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;

- (void)configContentView;
- (void)bindViewModel;

- (void)reloadviewWhenDatasourceChange;
@end
