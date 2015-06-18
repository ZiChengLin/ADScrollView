//
//  ADDataModel.h
//  ADScrollView
//
//  Created by 林梓成 on 15/6/18.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDataModel : NSObject

@property (nonatomic, retain, readonly) NSArray *imageNameArray;
@property (nonatomic, retain, readonly) NSArray *adTitleArray;

- (instancetype)initWithImageName;
- (instancetype)initWithImageNameAndAdTitleArray;
+ (id)adDataModelWithImageName;
+ (id)adDataModelWithImageNameAndAdTitleArray;

@end
