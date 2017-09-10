//
//  SetPasswordViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"

@interface SetPasswordViewModel : BaseViewModel
@property (nonatomic, copy)   NSString *phoneNumberStr;
@property (nonatomic, copy)   NSString *vertifyCodeStr;
@property (nonatomic, copy)   NSString *passwordStr;
@property (nonatomic, copy)   NSString *confirmPwdStr;

@property (nonatomic, strong) RACSignal *savePwdSignal;
@property (nonatomic, strong) RACCommand *fetchVCodeCommand;
@end
