//
//  NSUserDefaults+UserDefaults.m
//  TemplateTest
//
//  Created by HW on 17/8/31.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "NSUserDefaults+UserDefaults.h"

#define kFirstLauch     @"isFirstLauch"

@implementation NSUserDefaults (UserDefaults)

+ (instancetype)share {
    return [NSUserDefaults standardUserDefaults];
}

- (void)setIsLaunched:(BOOL)isLaunched {
    [self setObject:@(isLaunched) forKey:kFirstLauch];
}

- (BOOL)isLaunched {
    id value = [self objectForKey:kFirstLauch];
    return [value boolValue];
}

@end
