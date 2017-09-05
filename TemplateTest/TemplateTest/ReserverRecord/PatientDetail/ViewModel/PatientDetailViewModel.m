//
//  PatientDetailViewModel.m
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailViewModel.h"

@interface PatientDetailViewModel ()
@property (nonatomic, strong, readwrite) PatientDetailModel *model;
@end
@implementation PatientDetailViewModel

- (void)bindViewWithSignal {
    @weakify(self);
    self.requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self post:kReserverRecordDetail type:0 params:@{} success:^(id response) {
            
        } failure:^(NSString *error) {
            PatientDetailModel *model = [PatientDetailModel new];
            for (int i=0; i<3; i++) {
                
                model.imagesArray = @[@{@"date":@"2017-07-23",@"images":@[@"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg",@"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg",@"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg",@"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg",@"http://img.taopic.com/uploads/allimg/140322/235058-1403220K93993.jpg"]}];
                [self caculateCellHeight:model];
            }
            self.model = model;
            [subscriber sendError:[NSError errorWithDomain:error code:404 userInfo:nil]];
        }];
        return nil;
    }];
}

- (void)caculateCellHeight:(PatientDetailModel *)model {
    model.imagesCellsHeight = [NSMutableArray arrayWithCapacity:model.imagesArray.count];
    for (int i=0; i<model.imagesArray.count; i++) {
        NSArray *images = [[model.imagesArray objectAtIndex:i]objectForKey:@"images"];
        CGFloat height = kPhotoTitleY;
        NSInteger row = images.count/3+1;
        height += row*(kPhotoHeight+(row-1)*kPhotoSpaceY);
        [model.imagesCellsHeight addObject:@(height)];
    }
}

@end
