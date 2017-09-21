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
    
    [self.usernameSignal subscribeNext:^(UITextField *x) {
        weakUserLogin.userPhone = x.text;
    }];
    [self.vertifyCodeSignal subscribeNext:^(UITextField *x) {
        weakUserLogin.vertifyCode = x.text;
    }];
    
    @weakify(self);
    self.gainCodeChannel = [RACChannel new];
    [gainCodeChannel.followingTerminal subscribeNext:^(UIButton *sender) {
        @strongify(self);
        if (weakUserLogin.userPhone.length >= 11) {
            [self post:kLoginGainVertifyCode type:0 params:@{@"mobile": weakUserLogin.userPhone,@"type":@"1"} success:^(id response) {
                [self.gainCodeChannel.followingTerminal sendNext:[RACSignal return:response]];
            } failure:^(NSString *error) {
                [self.gainCodeChannel.followingTerminal sendNext:[RACSignal error:Error]];
            }];
        } else {
            [self.gainCodeChannel.followingTerminal sendNext:[RACSignal error:[NSError errorWithDomain:@"手机号不正确" code:404 userInfo:nil]]];
        }
        
    }];
    
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            HWUserLogin *userLogin = weakUserLogin;
            if (userLogin.vertifyCode.length==6 && userLogin.userPhone.length==11) {
                [self post:kLoginApp type:0 params:@{@"mobile":userLogin.userPhone,
                                                     @"randCode":userLogin.vertifyCode}
                   success:^(id response) {
                       [subscriber sendCompleted];
                       [HWCoreDataManager saveUserInfo];
                   } failure:^(NSString *error) {
                       [subscriber sendError:Error];
                   }];
            } else {
                [subscriber sendError:[NSError errorWithDomain:@"用户名或密码不正确" code:404 userInfo:nil]];
            }
            return nil;
        }];
    }];
}

@end
