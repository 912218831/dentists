//
//  PatientDetailSuggestDataSource.h
//  TemplateTest
//
//  Created by HW on 17/9/6.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseListViewDataSource.h"
#import "PatientDetailViewModel.h"
#import "PatientDetailAbstractCell.h"

@interface PatientDetailSuggestDataSource : BaseListViewDataSource

- (instancetype)initWithViewModel:(PatientDetailViewModel *)viewModel reuseIdentifier:(NSString *)identifier;

@end
