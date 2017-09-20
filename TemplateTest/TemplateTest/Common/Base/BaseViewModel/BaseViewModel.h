//
//  BaseDataModel.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "BaseViewController.h"

typedef  NS_ENUM(int, APIType) {
    UserLogin = 1,
    HomeList ,
    NewList  ,
    PersonalInfo ,
};

#define Error [NSError errorWithDomain:error code:404 userInfo:nil]

@class BaseViewController;
@interface BaseViewModel : NSObject
@property (nonatomic, copy, readwrite)   NSString     *url;
@property (nonatomic, copy, readwrite)   NSDictionary *params;
@property (nonatomic, copy, readwrite)   NSString     *title;
@property (nonatomic, copy, readwrite)   NSString     *rightImageName;
@property (nonatomic, copy, readwrite)   NSString     *leftImageName;
- (void)fetchRemoteServerData ;

- (void)bindModel:(NSDictionary *)response ;

- (void)bindViewWithSignal;

- (void)get:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure;

- (void)post:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure;

@end
