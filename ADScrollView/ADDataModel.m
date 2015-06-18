//
//  ADDataModel.m
//  ADScrollView
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ADDataModel.h"

#define PLISTFILENAME @"ADDataPlist.plist"
#define PATH          [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]

@implementation ADDataModel

- (void)dealloc {
    
    [_imageNameArray release];
    [_adTitleArray release];
    [super dealloc];
}

- (instancetype)initWithImageName {
    
    self = [super init];
    if (self) {
        
        _imageNameArray = [[NSArray alloc] initWithContentsOfFile:PATH][0];
    }
    return self;
}

- (instancetype)initWithImageNameAndAdTitleArray {
    
    _adTitleArray = [[NSArray alloc] initWithContentsOfFile:PATH][1];
    
    return [self initWithImageName];
}

+ (id)adDataModelWithImageName {
    
    return [[self alloc] initWithImageName];
}

+ (id)adDataModelWithImageNameAndAdTitleArray {
    
    return [[self alloc]initWithImageNameAndAdTitleArray];
}

@end
