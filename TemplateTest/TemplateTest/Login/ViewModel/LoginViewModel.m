//
//  LoginViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/2.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "LoginViewModel.h"
@interface LoginViewModel ()
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@end

@implementation LoginViewModel
@synthesize gainCodeChannel;

- (void)bindViewWithSignal {
    
    [self.usernameSignal subscribeNext:^(id x) {
        weakUserLogin.userPhone = x;
    }];
    [self.vertifyCodeSignal subscribeNext:^(id x) {
        weakUserLogin.vertifyCode = x;
    }];
    
    @weakify(self);
    self.gainCodeChannel = [RACChannel new];
    [gainCodeChannel.followingTerminal subscribeNext:^(UIButton *sender) {
        @strongify(self);
        [self post:kLoginGainVertifyCode type:0 params:@{} success:^(id response) {
            [self.gainCodeChannel.followingTerminal sendNext:response];
        } failure:^(NSString *error) {
            [self.gainCodeChannel.followingTerminal sendNext:error];
        }];
    }];
    
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            if (1) {//weakUserLogin.userPassword.length && weakUserLogin.username.length
                [self post:kLoginApp type:0 params:@{}
                   success:^(id response) {
                       [subscriber sendNext:response];
                       [subscriber sendCompleted];
                       [HWCoreDataManager saveUserInfo];
                   } failure:^(NSString *error) {
                       [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
                   }];
            }
            return nil;
        }];
    }];
}

@end
