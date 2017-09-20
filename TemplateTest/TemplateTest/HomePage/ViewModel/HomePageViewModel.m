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
                NSLog(@"%@",response);
                NSDictionary *data = [response dictionaryObjectForKey:@"data"];
                self.unconfirmed = [data stringObjectForKey:@"unconfirmed"];
                self.confirmed = [data stringObjectForKey:@"confirmed"];
                
                NSMutableArray *all = [NSMutableArray array];
                
                NSArray *confirmedListAm = [data arrayObjectForKey:@"confirmedListAm"];
                NSMutableArray *arr = [NSMutableArray arrayWithCapacity:confirmedListAm.count];
                for (NSDictionary *item in confirmedListAm) {
                    HPReserverListModel *model = [[HPReserverListModel alloc]initWithDictionary:item error:nil];
                    [arr addObject:model];
                    [all addObject:model];
                }
                self.confirmedListAm = arr.copy;
                
                NSArray *confirmedListPm = [data arrayObjectForKey:@"confirmedListPm"];
                NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:confirmedListPm.count];
                for (NSDictionary *item in confirmedListPm) {
                    HPReserverListModel *model = [[HPReserverListModel alloc]initWithDictionary:item error:nil];
                    [arr1 addObject:model];
                    [all addObject:model];
                }
                self.confirmedListPm = arr1.copy;
                
                self.allConfirmedList = all.copy;
                
                NSArray *next7days = [data arrayObjectForKey:@"next7days"];
                NSMutableArray *list = [NSMutableArray arrayWithCapacity:next7days.count];
                for (NSDictionary *item in next7days) {
                    HPReserverPeopleModel *model = [[HPReserverPeopleModel alloc]initWithDictionary:item error:nil];
                    [list addObject:model];
                }
                self.reserverPeoples = list.copy;
                [subscriber sendCompleted];
            } failure:^(NSString *error) {
                [subscriber sendError:Error];
            }];
            return nil;
        }];
    }];
}

@end
