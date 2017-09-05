//
//  RRSearchResultViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "RRSearchResultViewModel.h"

@interface RRSearchResultViewModel ()
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;
@end
@implementation RRSearchResultViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)bindViewWithSignal {
    @weakify(self);
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSString *keyword) {
        @strongify(self);
        self.searchKey = keyword;
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self post:kReserverRecordSearch type:0 params:@{} success:^(id reponse) {
                [subscriber sendCompleted];
            } failure:^(NSString *error) {
                for (int i=0; i<5; i++) {
                    NSDictionary *dict = @ {
                        @"appointmentid":@"1234321",
                        @"date":@"2017-7-15",
                        @"ampm":@"1",
                        @"patientname":@"张先生",
                        @"headimage":@"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg",
                        @"suggestiong":@"可能是牙菌斑比较严重",
                        @"state":@"0"
                    };
                    NSError *err = nil;
                    PatientModel *model = [[PatientModel alloc]initWithDictionary:dict error:&err];
                    [self.dataSource addObject:model];
                }
                [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
            }];
            
            return nil;
        }];
    }];
}

@end
