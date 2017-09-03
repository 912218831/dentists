//
//  HWLoginUser+CoreDataProperties.m
//  TemplateTest
//
//  Created by HW on 17/8/31.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWLoginUser+CoreDataProperties.h"

@implementation HWLoginUser (CoreDataProperties)

+ (NSFetchRequest<HWLoginUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HWLoginUser"];
}

@dynamic key;
@dynamic userName;
@dynamic userPhone;
@dynamic userType;
@dynamic userPassword;

@end
