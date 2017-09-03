//
//  HTTPProtocol.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/26.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPProtocol <NSObject>

- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *error))failure;

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *error))failure;

@end


@protocol ParserDataProtocol <NSObject>

- (id)parserData_Dictionary:(NSDictionary *)jsonData;

@end


@protocol PersistentDataProtocol <NSObject>

- (void)saveData;

- (void)insertData:(NSDictionary *)dic;

- (void)findData:(NSString *)userId;

@end

@protocol ListViewProtocol <NSObject>

- (void)reloadData ;

@end

@protocol MVVMViewProtocol <NSObject>

@end

@class BaseViewModel;

typedef void (^VoidBlock)(UIViewController *targetVC);

@protocol NavigationProtocol <NSObject>

- (void)pushViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

- (void)resetRootViewModel:(BaseViewModel *)viewModel;


@end


@protocol HWBaseViewProtocol <NSObject>
- (void)initSubViews;
- (void)layoutSubViews;
- (void)initDefaultConfigs;
@end


@protocol BindSignal <NSObject>

- (void)bindSignal;

@end
