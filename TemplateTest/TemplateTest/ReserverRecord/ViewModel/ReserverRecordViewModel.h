//
//  RRViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/4.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"
#import "PatientModel.h"

@interface ReserverRecordViewModel : BaseViewModel
@property (nonatomic, strong, readonly) NSMutableArray *dataSource;
@property (nonatomic, strong) RACCommand *requestCommand;
@end
