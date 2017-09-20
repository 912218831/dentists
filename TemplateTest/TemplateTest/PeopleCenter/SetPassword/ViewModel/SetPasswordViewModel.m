//
//  SetPasswordViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "SetPasswordViewModel.h"

@implementation SetPasswordViewModel

- (void)bindViewWithSignal {
    @weakify(self);
    self.savePwdSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self post:kPersonCenterChangePwd type:0 params:@{} success:^(id response) {
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
        }];
        return nil;
    }];
    
    //
    self.fetchVCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSString *err = nil;
            if (!self.phoneNumberStr.length) {
                err = @"手机号不能为空";
            } else if (self.phoneNumberStr.length!=11) {
                err = @"手机号不正确";
            } else if (!self.vertifyCodeStr.length) {
                err = @"验证码不能为空";
            } else if (self.vertifyCodeStr.length!=6) {
                err = @"验证码不正确";
            } else if (!self.passwordStr.length) {
                err = @"密码不能为空";
            } else if (![self.passwordStr isEqualToString:self.confirmPwdStr]) {
                err = @"密码和确认密码不一致";
            }
            if (err) {
                [subscriber sendError:[NSError errorWithDomain:err code:404 userInfo:nil]];
            } else {
                [self post:kPersonCenterGainVertifyCode type:0 params:@{@"mobile":self.phoneNumberStr,@"type":@"1"} success:^(id response) {
                    [subscriber sendCompleted];
                } failure:^(NSString *error) {
                    [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
                }];
            }
            
            return nil;
        }];
    }];
}

@end
