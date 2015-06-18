//
//  ADScrollView.h
//  ADScrollView
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIPageControlShowStyle) {

    UIPageControlShowStyleNone,     //default
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight
};

typedef NS_ENUM(NSUInteger, AdTitleShowStyle) {

    AdTitleShowStyleNone,
    AdTitleShowStyleLeft,
    AdTitleShowStyleCenter,
    AdTitleShowStyleRight
};


@interface ADScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, retain, readonly) UIPageControl *pageControl;
@property (nonatomic, retain, readwrite) NSArray *imageNameArray;
@property (nonatomic, retain, readonly) NSArray *adTitleArray;
@property (nonatomic, assign, readwrite) UIPageControlShowStyle PageControlShowStyle;
@property (nonatomic, assign, readonly) AdTitleShowStyle adTitleStyle;

- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle;

@end
