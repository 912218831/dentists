//
//  HomePageViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HomePageViewModel.h"

@implementation HomePageViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self bindViewWithSignal];
    }
    return self;
}

- (void)bindViewWithSignal {
    @weakify(self);
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self post:kHomePageInformation type:0 params:@{} success:^(id response) {
                
            } failure:^(NSString *error) {
                NSMutableArray *list = [NSMutableArray array];
                for (int i=0; i<6; i++) {
                    HPReserverPeopleModel *item = [HPReserverPeopleModel new];
                    item.patientName = @"张三";
                    item.patientPhoto = @"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg";
                    [list addObject:item];
                }
                self.reserverPeoples = list.copy;
                [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
            }];
            return nil;
        }];
    }];
}

@end
