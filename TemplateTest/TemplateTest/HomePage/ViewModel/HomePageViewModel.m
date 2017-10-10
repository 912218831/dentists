//
//  HomePageViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HomePageViewModel.h"
#import "MyPatientsViewModel.h"

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
                // 这个字典只是为了获取数据用的，利用 key 唯一，来填充 object
                NSMutableDictionary *list = [NSMutableDictionary dictionaryWithCapacity:7];
                for (NSDictionary *item in next7days) {
                    HPReserverPeopleModel *model = [[HPReserverPeopleModel alloc]initWithDictionary:item error:nil];
                    NSString *key = [NSString stringWithFormat:@"%@",model.expectedTime];
                    NSMutableDictionary *itemDict = [list objectForKey:key];
                    if (!itemDict) {
                        itemDict = [NSMutableDictionary dictionaryWithCapacity:2];
                        [list setObject:itemDict forKey:key];
                    }
                    NSMutableArray *amPm = [itemDict objectForKey:model.amPm];
                    if (!amPm) {
                        amPm = [NSMutableArray array];
                        [itemDict setObject:amPm forKey:model.amPm];
                    }
                    [amPm addObject:model];
                }
                // 这个数组，是为了利用其进行排序
                NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:7];
                for (NSString *key in list.allKeys) {
                    NSDictionary *obj = [list objectForKey:key];
                    [resultArr addObject:@{key:obj}];
                }
                [resultArr sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
                    NSMutableString *key1 = [obj1.allKeys.lastObject mutableCopy];
                    NSMutableString *key2 = [obj2.allKeys.lastObject mutableCopy];
                    [key1 replaceOccurrencesOfString:@"-" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, key1.length)];
                    [key2 replaceOccurrencesOfString:@"-" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, key1.length)];
                    if (key1.integerValue > key2.integerValue) {
                        return NSOrderedDescending;
                    } else {
                        return NSOrderedAscending;
                    }
                }];
                // 最终取值
                NSMutableArray *reserverPeoples = [NSMutableArray arrayWithCapacity:resultArr.count*2];
                NSMutableArray *mutableTime = [NSMutableArray arrayWithCapacity:resultArr.count];
                for (int i=0; i<resultArr.count; i++) {
                    NSDictionary *item = [[[resultArr objectAtIndex:i]allObjects]lastObject];
                    [mutableTime addObject:[[resultArr objectAtIndex:i] allKeys].lastObject];
                    NSArray *am = [item arrayObjectForKey:@"0"];
                    NSArray *pm = [item arrayObjectForKey:@"1"];
                    [reserverPeoples addObject:am];
                    [reserverPeoples addObject:pm];
                }
                self.expectedTimes = mutableTime.copy;
                self.reserverPeoples = reserverPeoples.copy;
                [subscriber sendCompleted];
            } failure:^(NSString *error) {
                [subscriber sendError:Error];
            }];
            return nil;
        }];
    }];
    //
    RACSignal *observeWait = [[RACObserve(self, waitAffirmSignal)filter:^BOOL(id value) {
        return value;
    }] distinctUntilChanged];
    [observeWait.switchToLatest subscribeNext:^(RACSignal *x) {
        // 待确认预约
        NSLog(@"signal=%@,---",x);
        @strongify(self);
        [[ViewControllersRouter shareInstance]popToRootViewModelAnimated:false];
        HWTabBarViewController *tabbarVC = SHARED_APP_DELEGATE.tabBarVC;
        BaseViewController *vc = [tabbarVC.viewControllers objectAtIndex:1];
        [vc.navigationController popViewControllerAnimated:false];
        [tabbarVC setSelectedIndex:1];
    }];
    [[[RACObserve(self, reserveredSignal)filter:^BOOL(id value) {
        return value;
    }]distinctUntilChanged].switchToLatest subscribeNext:^(id x) {
        // 已预约
        @strongify(self);
        [[ViewControllersRouter shareInstance]popToRootViewModelAnimated:false];
        HWTabBarViewController *tabbarVC = SHARED_APP_DELEGATE.tabBarVC;
        BaseViewController *vc = [tabbarVC.viewControllers objectAtIndex:1];
        [vc.navigationController popViewControllerAnimated:false];
        [tabbarVC setSelectedIndex:1];
    }];
    //
    self.tapCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(RACTuple *input) {
        @strongify(self);
        NSNumber *first = input.first;
        NSNumber *second = input.second;
        NSArray *arr = [self.reserverPeoples objectAtIndex:first.integerValue];
        HPReserverPeopleModel *model = [arr objectAtIndex:second.integerValue];
        
        [[ViewControllersRouter shareInstance]popToRootViewModelAnimated:false];
        HWTabBarViewController *tabbarVC = SHARED_APP_DELEGATE.tabBarVC;
        UINavigationController *vc = [tabbarVC.viewControllers objectAtIndex:1];
        
        MyPatientsViewModel *rrViewModel = [[MyPatientsViewModel alloc]init];
        rrViewModel.urlStr = [NSString stringWithFormat:@"%@&id=%@",AppendHTML(kReserverDetailHTML),model.Id];
        rrViewModel.title = @"病人详情";
        rrViewModel.leftImageName = @"TOP_ARROW";
        [tabbarVC setTabBarHidden:true];
        UIViewController *baseVC = [[ViewControllersRouter shareInstance]controllerMatchViewModel:rrViewModel];
        [vc pushViewController:baseVC animated:false];
        [tabbarVC setSelectedIndex:1];
        
        return [RACSignal empty];
    }];
    
    self.todayTapCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *input) {
        @strongify(self);
        HPReserverListModel *model = [self.allConfirmedList objectAtIndex:input.integerValue];
        [[ViewControllersRouter shareInstance]popToRootViewModelAnimated:false];
        [(HWTabBarViewController*)SHARED_APP_DELEGATE.tabBarVC setSelectedIndex:1];
        return [RACSignal empty];
    }];
}

@end
