//
//  ProtocolTerminal.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtocolTerminal : NSProxy <HTTPProtocol, ParserDataProtocol, PersistentDataProtocol>

+ (instancetype)sharedInstance ;
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler;

@end
