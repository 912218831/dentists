//
//  LoginViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/2.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel
@property (nonatomic, strong) RACSignal *usernameSignal;
@property (nonatomic, strong) RACChannel *gainCodeChannel;
@property (nonatomic, strong) RACSignal *vertifyCodeSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
