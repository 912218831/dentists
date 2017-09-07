//
//  RRViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/4.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "ReserverRecordViewModel.h"

@interface ReserverRecordViewModel ()
@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;
@end
@implementation ReserverRecordViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)bindViewWithSignal {
    @weakify(self);
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self post:kReserverRecordList type:0 params:@{} success:^(id response) {
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
