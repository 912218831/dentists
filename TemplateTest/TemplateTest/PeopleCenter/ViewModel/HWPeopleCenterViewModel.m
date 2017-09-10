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
        [self post:kPersonCenterInfo type:0 params:@{} success:^(id response) {
            
        } failure:^(NSString *error) {
            self.userName = @"吴先生";
            self.userPhone = @"18225523932";
            self.headImageUrl = [NSURL URLWithString:@"http://img5.imgtn.bdimg.com/it/u=1380084653,2448555822&fm=27&gp=0.jpg"];
            [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
        }];
        return nil;
    }];
}

@end
