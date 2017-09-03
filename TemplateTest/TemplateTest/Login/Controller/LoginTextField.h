//
//  LoginTextField.h
//  TemplateTest
//
//  Created by HW on 17/9/2.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseView.h"

@interface LoginTextField : BaseView
@property (nonatomic, strong, readonly) UILabel *leftLabel;
@property (nonatomic, assign) BOOL needRightBtn;
@property (nonatomic, strong) RACChannel *rightChannel;
@property (nonatomic, strong, readonly) UITextField *textfield;
@end
