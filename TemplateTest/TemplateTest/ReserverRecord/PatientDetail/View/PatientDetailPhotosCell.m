//
//  PatientDetailPhotosCell.m
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailPhotosCell.h"

@interface PatientDetailPhotosCell ()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *signView;
@property (nonatomic, strong) NSMutableArray *imageViewsArray;
@end

@implementation PatientDetailPhotosCell

- (void)initSubViews {
    self.dateLabel = [UILabel new];
    self.signView = [UIView new];
    [self addSubview:self.dateLabel];
    [self addSubview:self.signView];
}

- (void)layoutSubViews {
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kRate(15));
        make.top.equalTo(self).with.offset(kRate(21));
        make.height.mas_equalTo(kRate(16));
        make.width.mas_equalTo(kRate(4));
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.signView);
        make.left.equalTo(self.signView.mas_right).with.offset(kRate(10));
    }];
}

- (void)initDefaultConfigs {
    self.backgroundColor = COLOR_F3F3F3;
    self.signView.layer.cornerRadius = kRate(2);
    self.signView.layer.backgroundColor = CD_MainColor.CGColor;
    self.dateLabel.font = FONT(TF14);
    self.dateLabel.textColor = COLOR_999999;
    
    self.imageViewsArray = [NSMutableArray array];
    self.dateLabel.text = @"2017-07-20";
}

- (void)setImagesSignal:(RACSignal *)imagesSignal {
    _imagesSignal = imagesSignal;
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self);
    [self.imagesSignal subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        NSArray *images = [tuple allObjects];
        CGFloat x = kRate(15);
        CGFloat y = kPhotoTitleY;
        for (int i=0; i<images.count; i++) {
            int row = i/3;
            int col = i%3;
            x =  kRate(15)+ col*(kPhotoWith+kPhotoSpaceX);
            y = kPhotoTitleY + row*(kPhotoHeight+kPhotoSpaceY);
            
            UIImageView *imageView = [self.imageViewsArray pObjectAtIndex:i];
            if (!imageView) {
                imageView = [UIImageView new];
                imageView.layer.cornerRadius = 3;
                imageView.layer.masksToBounds = true;
                imageView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
                imageView.layer.borderWidth = 0.3;
                [self.imageViewsArray addObject:imageView];
            }
            [self addSubview:imageView];
            imageView.frame = CGRectMake(x, y, kPhotoWith, kPhotoHeight);
            [imageView sd_setImageWithURL:[NSURL URLWithString:images[i]]];
        }
        if (self.imageViewsArray.count > images.count) {
            [self.imageViewsArray removeObjectsInRange:NSMakeRange(images.count, self.imageViewsArray.count-images.count)];
        }
    }];
}

@end
