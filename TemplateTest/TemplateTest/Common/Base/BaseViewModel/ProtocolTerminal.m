//
//  ProtocolTerminal.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ProtocolTerminal.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ProtocolTerminal ()
@property (strong, nonatomic) NSMutableDictionary *selToHandlerMap;
@end

@implementation ProtocolTerminal
static ProtocolTerminal *instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [ProtocolTerminal alloc];
        instance.selToHandlerMap = [@{} mutableCopy];
    });
    
    return instance;
}

- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler {
    unsigned int numberOfMethods = 0;
    
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(httpProtocol, YES, YES, &numberOfMethods);
    
    for (unsigned int i=0; i<numberOfMethods; i++ ) {
        struct objc_method_description method = methods[i];
        [_selToHandlerMap setValue:handler forKey:NSStringFromSelector(method.name)];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSString *methodsName = NSStringFromSelector(sel);
    
    id handler = [_selToHandlerMap valueForKey:methodsName];
    
    if (handler != nil && [handler respondsToSelector:sel]) {
        return [handler methodSignatureForSelector:sel];
    }else{
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    NSString *methodsName = NSStringFromSelector(invocation.selector);
    id handler = [_selToHandlerMap valueForKey:methodsName];
    
    if (handler != nil && [handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
    }else{
        [super forwardInvocation:invocation];
    }
}
@end
