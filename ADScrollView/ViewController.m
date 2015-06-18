//
//  ViewController.m
//  ADScrollView
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ViewController.h"
#import "ADScrollView.h"
#import "ADDataModel.h"

#define UISCREENWIDTH  self.view.bounds.size.width
#define UISCREENHEIGHT self.view.bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
}

#pragma mark - 创建广告滚动视图
- (void)createScrollView {
    
    ADScrollView *scrollView = [[ADScrollView alloc] initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 150)];
    ADDataModel *dataModel = [ADDataModel adDataModelWithImageNameAndAdTitleArray];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    NSLog(@"%@", dataModel.adTitleArray);
    
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
