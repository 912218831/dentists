//
//  HWPeopleCenterViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"

@interface HWPeopleCenterViewModel : BaseViewModel
@property (nonatomic, copy) NSURL *headImageUrl;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, strong) RACSignal *loginOutSignal;
@property (nonatomic, strong) RACSignal *requestSignal;
@end
