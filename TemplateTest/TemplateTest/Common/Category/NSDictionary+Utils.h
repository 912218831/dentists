//
//  NSDictionary+Utils.h
//  LoveClub
//
//  Created by huangpeng on 13-7-21.
//  Copyright (c) 2013年 LoveClubbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(Utils)
//取值用的。
- (void)setPObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end

@interface NSDictionary(Utils)

//对返回数据格式进行限制，保证程序不崩溃
- (NSArray*)arrayObjectForKey:(NSString*)akey;
- (id)stringObjectForKey:(id)aKey;
- (NSDictionary *)dictionaryObjectForKey:(id)aKey;
- (id)numberObjectForKey:(id)aKey;
@end
