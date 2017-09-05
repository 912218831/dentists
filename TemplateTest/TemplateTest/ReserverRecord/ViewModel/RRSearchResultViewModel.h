//
//  RRSearchResultViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"
#import "PatientModel.h"

@interface RRSearchResultViewModel : BaseViewModel
@property (nonatomic, strong) RACCommand *command;
@property (nonatomic, strong, readonly) NSMutableArray *dataSource;
@end
