//
//  ReserverRecordCell.h
//  TemplateTest
//
//  Created by HW on 17/9/4.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseListViewCell.h"
#import "PatientModel.h"
@interface ReserverRecordCell : BaseListViewCell
@property (nonatomic, strong) RACSignal *signal;
@end
