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
            [subscriber sendNext:@1];
        } failure:^(NSString *error) {
            [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
        }];
        return nil;
    }];
    
    //
    self.fetchVCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self post:kPersonCenterGainVertifyCode type:0 params:@{} success:^(id response) {
                [subscriber sendNext:@1];
            } failure:^(NSString *error) {
                [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
            }];
            return nil;
        }];
    }];
}

@end
