//
//  PatientDetailDateCell.m
//  TemplateTest
//
//  Created by HW on 17/9/6.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailDateCell.h"
#import "DashLineView.h"

#define UIRectCornerNone (0)
#define kRow (3)
#define kCol (4)
@interface PatientDetailDateCell ()
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) NSMutableArray *titleLables;
@property (nonatomic, strong) UILabelWithCorner *selectedLabel;
@end

@implementation PatientDetailDateCell

- (void)initSubViews {
    self.contentV = [UIView new];
    [self addSubview:self.contentV];
    
    self.titleLables = [NSMutableArray arrayWithCapacity:kRow + kCol];
    for (int row=0; row<kRow; row++) {
        for (int col=0; col<kCol; col++) {
            UILabelWithCorner *label = [[UILabelWithCorner alloc]init];
            label.indexPath = [NSIndexPath indexPathForRow:row inSection:col];
            [self.contentV addSubview:label];
            [self.titleLables addObject:label];
        }
    }
}

- (void)layoutSubViews {
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kRate(15));
        make.right.equalTo(self).with.offset(-kRate(15));
        make.top.equalTo(self).with.offset(kRate(10));
        make.bottom.equalTo(self).with.offset(-kRate(1));
    }];
    CGFloat w = (kScreenWidth - kRate(30))/kCol;
    CGFloat h = (kPatientDetailDateCellHeight-kRate(10))/kRow;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i=0; i<self.titleLables.count; i++) {
        UILabelWithCorner *label = [self.titleLables objectAtIndex:i];
        NSInteger row = label.indexPath.row;
        NSInteger col = label.indexPath.section;
        x = col*w;
        y = row*h;
        label.frame = CGRectMake(x, row==0?1:y, (col==kCol-1)?w:w+1, h);
        NSLog(@"row=%ld, col=%ld",row, col);
    }
    
    DashLineView *hLine = [[DashLineView alloc]initWithLineHeight:kScreenWidth - kRate(30) space:0 direction:Horizontal strokeColor:COLOR_999999];
    [self.contentV addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentV);
        make.bottom.equalTo(self.contentV).with.offset(-h+1);
        make.height.mas_equalTo(0.6);
    }];
    for (int i=1; i<kCol; i++) {
        DashLineView *vLineOne = [[DashLineView alloc]initWithLineHeight:h*2 space:0 direction:Vertical strokeColor:COLOR_999999];
        [self.contentV addSubview:vLineOne];
        [vLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentV).with.offset(h);
            make.left.equalTo(self.contentV).with.offset(i*w);
            make.width.mas_equalTo(0.6);
            make.bottom.equalTo(self.contentV);
        }];
    }
}

- (void)initDefaultConfigs {
    self.backgroundColor = COLOR_F3F3F3;
    
    self.contentV.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    self.contentV.layer.cornerRadius = 3;
    self.contentV.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    self.contentV.layer.borderWidth = 0.6;
    
    for (int i=0; i<self.titleLables.count; i++) {
        UILabelWithCorner *label = [self.titleLables objectAtIndex:i];
        NSInteger row = label.indexPath.row;
        NSInteger col = label.indexPath.section;
        
        if (row == 0) {
            label.font = FONT(TF14);
            label.textColor = COLOR_FFFFFF;
            label.text = @"08-01";
            label.backgroundColor = UIColorFromRGB(0xfb6b35);
        } else {
            label.font = FONT(TF14);
            label.textColor = CD_Text99;
            label.text = @"上午（2）";
            label.backgroundColor = COLOR_FFFFFF;
        }
        
        if ((row == 0 && col == 0)) {
            label.corner = UIRectCornerTopLeft;
        } else if (row == 0 && col == kCol-1) {
            label.corner = UIRectCornerTopRight;
        } else if (row == kRow - 1 && col == 0) {
            label.corner = UIRectCornerBottomLeft;
        } else if (row == kRow - 1 && col == kCol-1) {
            label.corner = UIRectCornerBottomRight;
        } else {
            label.corner = UIRectCornerNone;
        }
        label.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)bindSignal {
    @weakify(self);
    for (int i=0; i<self.titleLables.count; i++) {
        UILabelWithCorner *label = [self.titleLables objectAtIndex:i];
        [[[label rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(UILabelWithCorner *value) {
            return value.indexPath.row!=0;
        }]subscribeNext:^(id x) {
            @strongify(self);
            label.backgroundColor = UIColorFromRGB(0xdff5fe);
            label.textColor = CD_MainColor;
            self.selectedLabel.backgroundColor = COLOR_FFFFFF;
            self.selectedLabel.textColor = CD_Text99;
            self.selectedLabel = label;
        }];
    }
}

- (void)dealloc {
    
}

@end



@interface UILabelWithCorner ()
@property (nonatomic, strong) UILabel *label;
@end
@implementation UILabelWithCorner

#pragma mark --- 设置 view layer 的 class
+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)init {
    if (self = [super init]) {
        self.label = [UILabel new];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        @weakify(self);
        [RACObserve(self, backgroundColor)subscribeNext:^(id x) {
            @strongify(self);
            CAShapeLayer *shape = (CAShapeLayer *)self.layer;
            shape.fillColor = self.backgroundColor.CGColor;
        }];
        /*
         这里用 rac_signalForSelector: 方法会有一个隐患，当 UITextfield、UITextView 等相关控件被使用（也就是 ）之后，会与 setBackgroundColor swizzle生成的方法产生冲突（目测只与改变外观的 swizzle 发生冲突），网上人说是 UIKit 框架的 bug,目前没办法解决
         （
         https://github.com/taplytics/taplytics-ios-sdk/issues/29
         
         First, what caused the crash on my project was using UIAppearance selector to change autocorrection mode for UITextFields, UITextViews and UISearchBars. But I ended up realizing it's an internal iOS bug, because on the assertion crash log Apple even prints out "if you see this assertion failing, please fill out a bug report in https://etc..."
         ）
         [[self rac_signalForSelector:@selector(setBackgroundColor:)]subscribeNext:^(id x) {
         }];
         */
        
    }
    return self;
}

- (void)setCorner:(UIRectCorner)corner {
    _corner = corner;
    if (corner != UIRectCornerNone) {
        CAShapeLayer *shape = (CAShapeLayer *)self.layer;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(3, 3)];
        shape.path = path.CGPath;
        shape.fillColor = self.backgroundColor.CGColor;
        [shape setBackgroundColor:[UIColor clearColor].CGColor];
    }
}

- (void)setFont:(UIFont *)font {
    self.label.font = font;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    self.label.textAlignment = textAlignment;
}

- (void)setTextColor:(UIColor *)textColor {
    self.label.textColor = textColor;
}
@end
