//
//  PatientDetailPhotosCell.h
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseListViewCell.h"

#define kPhotoWith   (kRate(109))
#define kPhotoHeight (kRate(110))
#define kPhotoSpaceX (kRate(10))
#define kPhotoSpaceY (kRate(10))
#define kPhotoTitleY (kRate(47))

@interface PatientDetailPhotosCell : BaseListViewCell
@property (nonatomic, strong) RACSignal *imagesSignal;
@end
