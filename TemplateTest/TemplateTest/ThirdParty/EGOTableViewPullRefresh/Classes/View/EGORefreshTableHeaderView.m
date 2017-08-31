//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"

#define CENTER_X (kScreenWidth / 2.0f - 75.0f + 25)

@interface EGORefreshTableHeaderView (Private)

@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor  {
    if((self = [super initWithFrame:frame])) {
        _frame = frame;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        YYImage * yyImg = [YYImage imageNamed:@"gif-1"];
        YYAnimatedImageView * animatedImgV = [YYAnimatedImageView newAutoLayoutView];
        animatedImgV.backgroundColor = COLOR_F3F3F3;
        [self addSubview:animatedImgV];
        [animatedImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-60];
        [animatedImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [animatedImgV autoSetDimension:ALDimensionHeight toSize:125];
        [animatedImgV autoSetDimension:ALDimensionWidth toSize:375];
        animatedImgV.image = yyImg;
        animatedImgV.autoPlayAnimatedImage = false;
        [self setState:EGOOPullRefreshNormal];
        
        self.animationImageView = animatedImgV;
    }
	
    return self;
	
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame arrowImageName:@"loading@2x.png" textColor:[UIColor redColor]];
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate
{
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceLastUpdated:)]) {
		
		
	}
     else
{
		

	}
    
}

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			
//			_statusLabel.text = @"释放更新数据";
			break;
		case EGOOPullRefreshNormal:
//			_statusLabel.text = @"下拉刷新";

			[self refreshLastUpdatedDate];
            
            
			break;
		case EGOOPullRefreshLoading:
			
//			_statusLabel.text = @"加载中...";
			
			break;
		default:
			break;
	}
	
	_state = aState;
}

-(void)runs
{
     angle += 50;
//    _arrowImage.transform  = CGAffineTransformMakeRotation((M_PI / 180.0) * angle);
    //CATransform3DMakeRotation((M_PI / 180.0) * angle, 0.0f, 0.0f, 1.0f);
}
#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidBeginScroll:(UIScrollView *)scrollView {
    [self.animationImageView startAnimating];
}

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
	if (_state == EGOOPullRefreshLoading) {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceIsLoading:)])
        {
			_loading = [_delegate egoRefreshTableDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading)
        {
			[self setState:EGOOPullRefreshNormal];
            
            
		}
        else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading)
        {
			[self setState:EGOOPullRefreshPulling];
            
            
		}
        else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y > -65.0f && !_loading)
        {
            [self setState:EGOOPullRefreshPulling];
            CGFloat scale = MIN(1.0f, (ABS(scrollView.contentOffset.y) / 65.0f));
//            _arrowImage.transform = CGAffineTransformMakeScale(scale, scale);
        }
        
        
		if (scrollView.contentInset.top != 0)
        {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}

//	NSLog(@"_state %d",_state);
}
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
	BOOL _loading = NO;
//    _arrowImage.hidden = YES;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableDidTriggerRefresh:EGORefreshHeader];
		}
		
		[self setState:EGOOPullRefreshLoading];
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
        
        
		
	}
	
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [self.animationImageView stopAnimating];
    [_timer invalidate];
      _timer = nil;
    [self performSelector:@selector(doneLoading:) withObject:scrollView afterDelay:1.5f];
	[self setState:EGOOPullRefreshNormal];
    
}

- (void)doneLoading:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc
{
    [self.animationImageView stopAnimating];
//    NSLog(@"doneLoading  dealloc ");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	_delegate=nil;
    [super dealloc];
}


@end
