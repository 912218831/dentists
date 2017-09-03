//
//  BaseListViewModel.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseListViewModel.h"
#import "BaseModel.h"

@interface BaseListViewModel ()
@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@end

@implementation BaseListViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)post:(NSString *)url type:(int)type params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure targetView:(UIView *)view message:(NSString *)message {
    
    NSDictionary *response = @{};
    NSArray *dataArray = @[];
    
    [self.dataArray removeAllObjects];
    @weakify(self);
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        BaseModel *item = [[BaseModel alloc]initWithDictionary:obj error:nil];
        [self.dataArray addObject:item];
        
        //[self.vc reloadviewWhenDatasourceChange];
    }];
}

@end
