//
//  PatientDetailViewModel.h
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseViewModel.h"
#import "PatientDetailModel.h"

#define kPhotoWith   (kRate(109))
#define kPhotoHeight (kRate(110))
#define kPhotoSpaceX (kRate(10))
#define kPhotoSpaceY (kRate(10))
#define kPhotoTitleY (kRate(47))

@interface PatientDetailViewModel : BaseViewModel
@property (nonatomic, copy) NSString *patientName;
@property (nonatomic, copy) NSString *appointmentid;
@property (nonatomic, strong) RACSignal *requestSignal;
@property (nonatomic, strong, readonly) PatientDetailModel *model;
@end
