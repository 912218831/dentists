//
//  HWPeopleCenterViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWPeopleCenterViewModel.h"

@implementation HWPeopleCenterViewModel

- (void)bindViewWithSignal {
    @weakify(self);
    self.requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self post:kPersonCenterInfo type:0 params:@{} success:^(NSDictionary* response) {
            NSDictionary *data = [response dictionaryObjectForKey:@"data"];
            self.userName = [data stringObjectForKey:@"nickName"];
            self.userPhone = weakUserLogin.userPhone;
            self.headImageUrl = [NSURL URLWithString:[data stringObjectForKey:@"headimage"]];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            
            [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
        }];
        return nil;
    }];
    
    self.loginOutCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self post:kPersonCenterLogout type:0 params:@{} success:^(id response) {
                [weakUserLogin userLogout];
                [subscriber sendNext:@1];
            } failure:^(NSString *error) {
                [subscriber sendError:Error];
            }];
            return nil;
        }];
    }];
}

@end
