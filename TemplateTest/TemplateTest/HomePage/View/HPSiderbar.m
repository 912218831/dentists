//
//  HPSiderbar.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HPSiderbar.h"
#import "DashLineView.h"
#import "HPReserverPeopleModel.h"

@interface HPSiderbar ()

@end

@implementation HPSiderbar

- (instancetype)initWithSolidLength:(CGFloat)solid dashedLength:(CGFloat)dashed dashedLineLength:(CGFloat)line dashedSapce:(CGFloat)space {
    if (self = [super init]) {
        @weakify(self);
        self.reloadCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSArray *dataSource) {
            @strongify(self);
            NSInteger count = dataSource.count/2 + (dataSource.count%2==0?0:1);
            CGFloat offY = 0;
            CGFloat offRight = kRate(4);
            CGFloat w = kRate(3);
            
            UIView *lastLineView = self;
            for (int i=0; i<count; i++) {
                HPReserverPeopleModel *model = [dataSource objectAtIndex:i];
                // 实线
                DashLineView *solidLine = [[DashLineView alloc]initWithLineHeight:solid space:0 direction:Vertical strokeColor:CD_MainColor];
                [self addSubview:solidLine];
                [solidLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastLineView == self) {
                        make.right.equalTo(lastLineView).with.offset(-(offRight*2-w)/2.0);
                        make.top.equalTo(lastLineView).with.offset(offY);
                    } else {
                        make.right.equalTo(lastLineView);
                        make.top.equalTo(lastLineView.mas_bottom);
                    }
                    make.height.mas_equalTo(solid);
                    make.width.mas_equalTo(w);
                }];
                
                if (1) {
                    // 首端小圆圈
                    CAShapeLayer *startCircleLayer = [CAShapeLayer layer];
                    startCircleLayer.frame = CGRectMake(w-1.5*offRight, 0, 2*offRight, 2*offRight);
                    startCircleLayer.path = [UIBezierPath bezierPathWithRoundedRect:startCircleLayer.bounds cornerRadius:offRight].CGPath;
                    startCircleLayer.strokeColor = CD_MainColor.CGColor;
                    startCircleLayer.fillColor = COLOR_FFFFFF.CGColor;
                    startCircleLayer.lineWidth = kRate(1);
                    [solidLine.layer addSublayer:startCircleLayer];
                    
                    // 末端小圆圈
                    CAShapeLayer *endCircleLayer = [CAShapeLayer layer];
                    endCircleLayer.frame = CGRectMake(w-1.5*offRight, solid-2*offRight, 2*offRight, 2*offRight);
                    endCircleLayer.path = [UIBezierPath bezierPathWithRoundedRect:endCircleLayer.bounds cornerRadius:offRight].CGPath;
                    endCircleLayer.strokeColor = CD_MainColor.CGColor;
                    endCircleLayer.fillColor = COLOR_FFFFFF.CGColor;
                    endCircleLayer.lineWidth = kRate(1);
                    [solidLine.layer addSublayer:endCircleLayer];
                    
                    // 左侧标题
                    UILabel *label = [UILabel new];
                    [self addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self);
                        make.right.equalTo(solidLine.mas_left);
                        make.centerY.equalTo(solidLine);
                    }];
                    label.text = model.expectedTime;//@"08/90";
                    label.textColor = CD_MainColor;
                    label.font = FONT(TF13);
                    label.textAlignment = NSTextAlignmentCenter;
                }
                // 虚线
                if (i == count -1) {
                    
                    break;
                }
                DashLineView *dashedLine = [[DashLineView alloc]initWithLineHeight:line space:space direction:Vertical strokeColor:UIColorFromRGB(0xcccccc)];
                [self addSubview:dashedLine];
                [dashedLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(solidLine.mas_bottom);
                    make.right.equalTo(solidLine);
                    make.height.mas_equalTo(dashed);
                    make.width.equalTo(solidLine);
                }];
                
                lastLineView = dashedLine;
            }
            
            return [RACSignal empty];
        }];
    }
    return self;
}

@end
