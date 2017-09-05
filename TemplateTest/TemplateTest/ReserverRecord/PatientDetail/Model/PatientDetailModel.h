//
//  PatientDetailModel.h
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseModel.h"

@interface PatientDetailModel : BaseModel
@property (nonatomic, copy) NSString *patient;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *appointmentdate;
@property (nonatomic, copy) NSString *ampm;
@property (nonatomic, strong) NSArray *imagesArray;//@[@{@"date":@"2017-07-23",@"images":@[@"",@"",@""]}]
@property (nonatomic, strong) NSMutableArray *imagesCellsHeight;
@end
