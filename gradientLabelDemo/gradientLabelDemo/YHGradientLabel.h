//
//  YHGradientLabel.h
//  test
//
//  Created by zhaohaifang on 2017/6/1.
//  Copyright © 2017年 HangzhouVongi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHGradientLabel : UILabel

@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) NSArray<NSNumber *> *locations;
@end
