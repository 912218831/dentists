//
//  HPFReserverPeopleCell.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HPFReserverPeopleCell.h"
#import "RDVTabBarItem.h"

@interface HPFReserverPeopleCell ()
@property (nonatomic, strong) NSMutableArray *patientButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HPFReserverPeopleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.patientButton = [NSMutableArray arrayWithCapacity:4];
    }
    return self;
}

- (void)initSubViews {
    self.scrollView = [[UIScrollView alloc]init];
    [self addSubview:self.scrollView];
}

- (void)layoutSubViews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRate(156/2.0));
        make.right.mas_equalTo(-kRate(15));
        make.top.bottom.equalTo(self);
    }];
}

- (void)initDefaultConfigs {
    
}

- (void)setSignal:(RACSignal *)signal {
    _signal = signal;
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self);
    [self.signal subscribeNext:^(NSArray *tuple) {
        @strongify(self);
        for (NSUInteger i=tuple.count; i<self.patientButton.count; i++) {
            UIControl *item = [self.patientButton objectAtIndex:i];
            item.hidden = true;
        }
        CGFloat offsetX = 0;
        CGFloat spaceX = kRate(20/2.0);
        CGFloat w = kRate(110/2.0);
        CGFloat h = kRate(156/2.0);
        for (NSInteger index = 0; index<tuple.count; index++) {
            HPReserverPeopleModel *model = [tuple objectAtIndex:index];
            
            UIControl *item = [self.patientButton pObjectAtIndex:index];
            if (!item) {
                item = [[UIControl alloc]init];
                [self.scrollView addSubview:item];
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.scrollView);
                    make.left.equalTo(self.scrollView).with.offset(offsetX);
                    make.width.mas_equalTo(w);
                    make.height.mas_equalTo(h);
                }];
                UIImageView *imageView = [UIImageView new];
                imageView.tag = 100;
                [item addSubview:imageView];
                UILabel *label = [UILabel new];
                [item addSubview:label];
                
                imageView.frame = (CGRect){CGPointZero, w, w};
                label.frame = (CGRect){0, w, w, h-w};
                
                label.font = FONT(TF14);
                label.textColor = CD_Text33;
                label.textAlignment = NSTextAlignmentCenter;
                imageView.layer.cornerRadius = w/2.0;
                imageView.layer.masksToBounds = true;
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                label.tag = 100;
                imageView.tag = 200;
                
                [self.patientButton addObject:item];
            }
            item.hidden = false;
            [[item rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                if (self.tapCommand) {
                    [self.tapCommand execute:RACTuplePack(@(self.indexPath.row),@(index))];
                }
            }];
            
            UILabel *label = [item viewWithTag:100];
            UIImageView *imageView = [item viewWithTag:200];
            imageView.image = nil;
            label.text = model.userName;
            if(model.headImgUrl.length)
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.headImgUrl]];
            offsetX += w + spaceX;
        }
        self.scrollView.contentSize = CGSizeMake(offsetX, 0);
    }];
}

@end
