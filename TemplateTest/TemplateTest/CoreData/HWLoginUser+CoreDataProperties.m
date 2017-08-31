//
//  HWLoginUser+CoreDataProperties.m
//  
//
//  Created by 杨庆龙 on 2017/7/28.
//
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

@end
