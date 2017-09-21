//
//  HomePageViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"
#import "HPReserverPeopleModel.h"
#import "HPReserverListModel.h"

@interface HomePageViewModel : BaseViewModel
@property (nonatomic, copy) NSString *unconfirmed;
@property (nonatomic, copy) NSString *confirmed;
@property (nonatomic, copy) NSArray *allConfirmedList;
@property (nonatomic, strong) NSArray *confirmedListAm;
@property (nonatomic, strong) NSArray *confirmedListPm;
@property (nonatomic, strong) NSArray *expectedTimes;
@property (nonatomic, strong) NSArray *reserverPeoples;
@property (nonatomic, strong) RACCommand *requestCommand;
@end
