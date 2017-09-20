//
//  VirtualSignal.m
//  TemplateTest
//
//  Created by HW on 17/9/14.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "VirtualSignal.h"

@interface VirtualSignal ()
@property (nonatomic, copy) void (^didSubscribe)(id<RACSubscriber>);
@end

@implementation VirtualSignal

+ (VirtualSignal *)createSignal:(void (^)(id<RACSubscriber>))didSubscribe {
    VirtualSignal *signal = [VirtualSignal new];
    signal.didSubscribe = didSubscribe;
    return signal;
}

- (VirtualSubscriber *)subscribeNext:(void (^)(id))nextBlock error:(void (^)(NSError *))errorBlock completed:(void (^)(void))completedBlock {
    VirtualSubscriber *subject = [VirtualSubscriber new];
    subject.nextBlock = nextBlock;
    subject.errorBlock = errorBlock;
    subject.completedBlock = completedBlock;
    self.didSubscribe(subject);
    return subject;
}

@end

@interface VirtualSubscriber ()
@property (nonatomic, copy) void (^finally)();
@end

@implementation VirtualSubscriber

- (void)sendNext:(id)value {
    if (self.nextBlock) {
        self.nextBlock(value);
    }
    if (self.finally) {
        self.finally();
    }
}

- (void)sendError:(NSError *)error {
    if (self.errorBlock) {
        self.errorBlock(error);
    }
    if (self.finally) {
        self.finally();
    }
}

- (void)sendCompleted {
    if (self.completedBlock) {
        self.completedBlock();
    }
    if (self.finally) {
        self.finally();
    }
}

- (void)finally:(void (^)())finallyBlock {
    self.finally = finallyBlock;
}

- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable {
    
}

@end
