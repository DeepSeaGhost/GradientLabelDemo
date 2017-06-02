//
//  ViewController.m
//  gradientLabelDemo
//
//  Created by zhaohaifang on 2017/6/2.
//  Copyright © 2017年 HangzhouVongi. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "YHGradientLabel.h"

@interface ViewController ()

@property (nonatomic, strong) YHGradientLabel *drawL;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ViewController

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.text = @"开始渐变人后一直编下去";
        _label.font = [UIFont systemFontOfSize:25];
    }
    return _label;
}
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
    }
    return _gradientLayer;
}

- (YHGradientLabel *)drawL {
    if (!_drawL) {
        _drawL = [[YHGradientLabel alloc]init];
        _drawL.textAlignment = NSTextAlignmentCenter;
        _drawL.text = @"开始渐变人后一直编下去开始渐变人后一直编";
        _drawL.font = [UIFont systemFontOfSize:18];
        _drawL.colors = @[[UIColor blueColor],[UIColor redColor],[UIColor orangeColor],[UIColor blackColor]];
        _drawL.locations = @[@0,@0.1,@0.7,@1];
    }
    return _drawL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.drawL];
    self.drawL.center = self.view.center;
    self.drawL.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    
    [self.view addSubview:self.label];
    CGSize size = [self.label.text sizeWithAttributes:@{NSFontAttributeName : self.label.font}];
    CGFloat height = [self.label sizeThatFits:CGSizeMake(size.width, MAXFLOAT)].height;
    self.label.frame = CGRectMake(50, 100, size.width, height);
    self.gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor];
    self.gradientLayer.locations = @[@0, @1];// 默认就是均匀分布
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    self.gradientLayer.frame = self.label.frame;
    self.gradientLayer.mask = self.label.layer;
    self.label.layer.frame = self.gradientLayer.bounds;
    [self.view.layer addSublayer:self.gradientLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
