//
//  YHGradientLabel.m
//  test
//
//  Created by zhaohaifang on 2017/6/1.
//  Copyright © 2017年 HangzhouVongi. All rights reserved.
//

#import "YHGradientLabel.h"
#import <CoreImage/CoreImage.h>

@implementation YHGradientLabel

- (void)drawRect:(CGRect)rect {
    //计算文字size
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    
    //计算文字绘制位置
    CGRect inRect = CGRectMake(0, (rect.size.height - textSize.height) / 2, textSize.width, textSize.height);
    switch (self.textAlignment) {
        case NSTextAlignmentLeft:
            break;
        case NSTextAlignmentCenter:
            inRect = CGRectMake((rect.size.width - textSize.width) / 2, (rect.size.height - textSize.height) / 2, textSize.width, textSize.height);
            break;
        case NSTextAlignmentRight:
            inRect = CGRectMake(rect.size.width - textSize.width, (rect.size.height - textSize.height) / 2, textSize.width, textSize.height);
            break;
        default:
            break;
    }
    
    //绘制
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [self.text drawInRect:inRect withAttributes:@{NSFontAttributeName : self.font}];
//    [self.text drawAtPoint:CGPointMake(0, (rect.size.height - textSize.height) / 2) withAttributes:@{NSFontAttributeName : self.font}];
    CGImageRef imageRef = CGBitmapContextCreateImage(ref);//获取mask
    
    //坐标转换
    CGContextTranslateCTM(ref, 0, rect.size.height);
    CGContextScaleCTM(ref, 1.f, -1.f);
    
    //清空画布
    CGContextClearRect(ref, rect);
    
    //设置mask
    CGContextClipToMask(ref, rect, imageRef);
    
    //设置渐变
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    //--->locations
    int locationSum = (int)self.locations.count;
    CGFloat locationArr[locationSum];
    for (int i = 0; i < locationSum; i ++) {
        locationArr[i] = [self.locations[i] floatValue];
    }
    //--->colors
    int colorSum = (int)self.colors.count * 4;
    CGFloat colorArr[colorSum];
    for (int i = 0; i < colorSum; i ++) {
        switch (i % 4) {
            case 0:
                colorArr[i] = [[[CIColor alloc]initWithColor:(UIColor *)self.colors[i / 4]] red];
                break;
            case 1:
                colorArr[i] = [[[CIColor alloc]initWithColor:(UIColor *)self.colors[i / 4]] green];
                break;
            case 2:
                colorArr[i] = [[[CIColor alloc]initWithColor:(UIColor *)self.colors[i / 4]] blue];
                break;
            case 3:
                colorArr[i] = [[[CIColor alloc]initWithColor:(UIColor *)self.colors[i / 4]] alpha];
                break;
            default:
                break;
        }
    }
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(spaceRef, colorArr, locationArr, self.colors.count);
    
    CGFloat minX = (rect.size.width - textSize.width) / 2;
    CGFloat minY = (rect.size.height - textSize.height) / 2;
    CGFloat maxX = (rect.size.width - textSize.width) / 2 + textSize.width;
    CGFloat maxY = (rect.size.height - textSize.height) / 2 + textSize.height;
    CGContextDrawLinearGradient(ref, gradientRef, CGPointMake(minX, minY), CGPointMake(maxX, minY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    //清理内存
    CGImageRelease(imageRef);
    CGColorSpaceRelease(spaceRef);
    CGGradientRelease(gradientRef);
}

@end
