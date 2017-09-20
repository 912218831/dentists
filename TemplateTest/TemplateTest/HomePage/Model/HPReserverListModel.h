//
//  HPReserverListModel.h
//  TemplateTest
//
//  Created by HW on 17/9/20.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseModel.h"

@interface HPReserverListModel : BaseModel
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *checkId;
@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *patintId;
@property (nonatomic, copy) NSString *dentistId;
@property (nonatomic, copy) NSString *expectedTime;
@property (nonatomic, copy) NSString *docExpectedTime;
@property (nonatomic, copy) NSString *amPm;
@property (nonatomic, copy) NSString *docAmPm;
@property (nonatomic, copy) NSString *dentistAgreedFlag;
@property (nonatomic, copy) NSString *patintAgreedFlag;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *patientName;
@property (nonatomic, copy) NSString *imageCount;
@property (nonatomic, copy) NSString *machineReport;

@end
