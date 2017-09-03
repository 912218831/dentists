//
//  NSUserDefaults+UserDefaults.h
//  TemplateTest
//
//  Created by HW on 17/8/31.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSUserDefaults UserDefault;

@interface NSUserDefaults (UserDefaults)

+ (instancetype)share;

/**
 * 是否是第一次登录
 */
@property (nonatomic, assign) BOOL isLaunched;

@end
