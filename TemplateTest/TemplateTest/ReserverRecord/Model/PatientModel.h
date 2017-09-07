//
//  PatientModel.h
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseModel.h"

@interface PatientModel : BaseModel
/*
 "appointmentid":"1234321",
 "date":"2017-7-15",
 "ampm":"1",
 "patientname":"张先生",
 "headimage":"http://abc.com/test.jpg",
 "suggestiong":"可能是牙菌斑比较严重",
 "state":"0"
 */
@property (nonatomic, copy) NSString *appointmentid;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *ampm;
@property (nonatomic, copy) NSString *patientname;
@property (nonatomic, copy) NSString *headimage;
@property (nonatomic, copy) NSString *suggestiong;
@property (nonatomic, copy) NSString *state;

@end
