//
//  HPReserverPeopleModel.h
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseModel.h"

@interface HPReserverPeopleModel : BaseModel
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *expectedTime;
@property (nonatomic, copy) NSString *amPm;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *headImgUrl;
@end
