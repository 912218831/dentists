//
//  BaseDataModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        [[ProtocolTerminal sharedInstance]registerHttpProtocol:@protocol(HTTPProtocol) handler:self];
        [[ProtocolTerminal sharedInstance]registerHttpProtocol:@protocol(ParserDataProtocol) handler:self];
        [[ProtocolTerminal sharedInstance]registerHttpProtocol:@protocol(PersistentDataProtocol) handler:self];
    }
    return self;
}

#pragma mark --- 请求方法
- (void)get:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure {
    [[ProtocolTerminal sharedInstance]get:url params:params success:^(id json) {
        success(json);
    } failure:^(NSString *error) {
        failure(error);
    }];
}

- (void)post:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure {
    [HWUserLogin currentUserLogin].userkey = @"3018797da6f7cc84831273de38bfe6eb";//@"00455ae9eff61c2eb0b59bb350b1c971";
    [[ProtocolTerminal sharedInstance]post:url params:params success:^(id json) {
        success(json);
    } failure:^(NSString *error) {
        failure(error);
    }];
}

- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure {
    [[HWHTTPSessionManger manager]HWPOST:url parameters:params success:^(id responese) {
        success(responese);
    } failure:^(NSString *code, NSString *error) {
        failure(error);
    }];
}

#pragma mark --- 网络数据处理方法
- (id)parserData_Dictionary:(NSDictionary *)jsonData {
    return nil;
}

- (void)bindViewWithSignal {}

@end
