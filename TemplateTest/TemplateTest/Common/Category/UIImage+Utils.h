//
//  UIImage+Utils.h
//  TemplateTest
//
//  Created by 杨庆龙 on 3/18/16.
//  Copyright © 2016 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

@end
