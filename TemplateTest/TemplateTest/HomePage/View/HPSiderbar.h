//
//  HPSiderbar.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseView.h"
#import "HomePageViewModel.h"

@interface HPSiderbar : BaseView
@property (nonatomic, strong) RACCommand *reloadCommand;
- (instancetype)initWithSolidLength:(CGFloat)solid dashedLength:(CGFloat)dashed dashedLineLength:(CGFloat)line dashedSapce:(CGFloat)space;
@end
