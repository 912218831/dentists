//
//  HomePageViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"
#import "HPReserverPeopleModel.h"

@interface HomePageViewModel : BaseViewModel
@property (nonatomic, strong) NSArray *reserverPeoples;
@property (nonatomic, strong) RACCommand *requestCommand;
@end
