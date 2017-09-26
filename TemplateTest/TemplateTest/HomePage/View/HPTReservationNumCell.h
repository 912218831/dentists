//
//  HPTReservationNumCell.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseListViewCell.h"
#import "DoubleLabelButton.h"

@interface HPTReservationNumCell : BaseListViewCell
@property (nonatomic, strong) RACSignal *waitAffirmSignal;// 待预约
@property (nonatomic, strong) RACSignal *reserveredSignal;// 已预约
@property (nonatomic, strong) DoubleLabelButton *waitAffirmBtn;
@property (nonatomic, strong) DoubleLabelButton *reserveredBtn;
@end
