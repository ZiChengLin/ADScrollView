//
//  ADScrollView.m
//  ADScrollView
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ADScrollView.h"

#define UISCREENWIDTH  self.bounds.size.width
#define UISCREENHEIGHT self.bounds.size.height
#define HEIGHT         self.bounds.origin.y     // 由于_pageControl是添加进父视图的。所以它的实际坐标要参考滚动视图的y坐标

static CGFloat const changeImageTime = 3.0;
static NSUInteger    currentImage = 1;


@interface ADScrollView ()
{
    UILabel *_adLabel;
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    
    NSTimer *_moveTime;
    BOOL _isTimeUp;
    
    UILabel *_leftAdLabel;
    UILabel *_centerAdLabel;
    UILabel *_rightAdLabel;
}

@property (nonatomic, retain, readonly) UIImageView * leftImageView;
@property (retain, nonatomic, readonly) UIImageView * centerImageView;
@property (retain, nonatomic, readonly) UIImageView * rightImageView;

@end


@implementation ADScrollView

#pragma mark - 自由指定图片的位置
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH * 2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_rightImageView];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:changeImageTime target:self selector:@selector(animaMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
    }
    
    return self;
}

#pragma mark - 设置广告所使用的图片
- (void)setImageNameArray:(NSArray *)imageNameArray {
    
    _imageNameArray = imageNameArray;
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[2]];
}

#pragma mark - 设置每个广告对应的广告语
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle {
    
    _adTitleArray = adTitleArray;
    
    if (adTitleStyle == AdTitleShowStyleNone) {
        
        return;
    }
    
    _leftAdLabel = [[UILabel alloc] init];
    _centerAdLabel = [[UILabel alloc] init];
    _rightAdLabel = [[UILabel alloc] init];

    _leftAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
    [_leftImageView addSubview:_leftAdLabel];
    _centerAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
    [_centerImageView addSubview:_centerAdLabel];
    _rightAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
    [_rightImageView addSubview:_rightAdLabel];
    
    if (adTitleStyle == AdTitleShowStyleLeft) {
        
        _leftAdLabel.textAlignment = NSTextAlignmentLeft;
        _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        _rightAdLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (adTitleStyle == AdTitleShowStyleCenter) {
        
        _leftAdLabel.textAlignment = NSTextAlignmentCenter;
        _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        _rightAdLabel.textAlignment = NSTextAlignmentCenter;
        
    } else {
        _leftAdLabel.textAlignment = NSTextAlignmentRight;
        _centerAdLabel.textAlignment = NSTextAlignmentRight;
        _rightAdLabel.textAlignment = NSTextAlignmentRight;
    }
    
    
    _leftAdLabel.text = _adTitleArray[0];
    _centerAdLabel.text = _adTitleArray[1];
    _rightAdLabel.text = _adTitleArray[2];
    
}

#pragma mark - 创建pageController 指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle {
    
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        
        return;
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _imageNameArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft) {
        
        _pageControl.frame = CGRectMake(10, HEIGHT + UISCREENHEIGHT - 20, 20 * _pageControl.numberOfPages, 20);
        
    } else if (PageControlShowStyle == UIPageControlShowStyleCenter) {
        
        _pageControl.frame = CGRectMake(0, 0, 20 * _pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH / 2.0, HEIGHT + UISCREENHEIGHT - 10);
        
    } else {
        
        _pageControl.frame = CGRectMake(UISCREENWIDTH - 20 * _pageControl.numberOfPages, HEIGHT + UISCREENHEIGHT - 20, 20 * _pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
    
}

// 因为PageControl这个控件必须要添加在滚动视图的父视图上（添加在滚动视图上的话会随着图片滚动而达不到效果）
- (void)addPageControl {
    
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时、系统滚动图片
- (void) animaMoveImage {
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
    
}

#pragma mark - 图片停止时、调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.contentOffset.x == 0) {
        
        currentImage = (currentImage - 1) % _imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage - 1) % _imageNameArray.count;
        
    } else if (self.contentOffset.x == UISCREENWIDTH * 2) {
        
        currentImage = (currentImage + 1) % _imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage + 1) % _imageNameArray.count;
        
    } else {
        
        return;
    }
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage-1)%_imageNameArray.count]];
    
    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_imageNameArray.count];
    
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]];
    
    _centerAdLabel.text = _adTitleArray[currentImage%_imageNameArray.count];
    
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
    
    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_imageNameArray.count];
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:changeImageTime]];
    }
    _isTimeUp = NO;
    
}


@end
