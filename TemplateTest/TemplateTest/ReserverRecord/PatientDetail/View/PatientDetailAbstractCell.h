//
//  PatientDetailAbstractCell.h
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseListViewCell.h"

@interface PatientDetailAbstractCell : BaseListViewCell
@property (nonatomic, strong) RACSignal *suggestTapSignal;
@property (nonatomic, assign) int state;
@end
