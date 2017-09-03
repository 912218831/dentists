//
//  HWLoginUser+CoreDataProperties.h
//  TemplateTest
//
//  Created by HW on 17/8/31.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWLoginUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HWLoginUser (CoreDataProperties)

+ (NSFetchRequest<HWLoginUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *key;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *userPhone;
@property (nullable, nonatomic, copy) NSString *userType;
@property (nullable, nonatomic, copy) NSString *userPassword;

@end

NS_ASSUME_NONNULL_END
