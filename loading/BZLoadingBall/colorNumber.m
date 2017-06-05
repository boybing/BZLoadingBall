//
//  colorNumber.m
//  loading
//
//  Created by 冰仔 on 2017/6/5.
//  Copyright © 2017年 bingzaiJoker. All rights reserved.
//

#import "colorNumber.h"

@implementation colorNumber
@synthesize colorLabel;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        colorLabel.center = self.center;
        colorLabel.text = @"0%";
        colorLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:colorLabel];
        
        // 创建渐变层
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = colorLabel.frame;
        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor];
        gradientLayer.locations = @[@(0.25),@(0.75)];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        [self.layer addSublayer:gradientLayer];
        gradientLayer.mask = colorLabel.layer;
        colorLabel.frame = gradientLayer.bounds;
    }
    return self;
}
@end
