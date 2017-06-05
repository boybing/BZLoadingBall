//
//  Waves.m
//  loading
//
//  Created by 冰仔 on 2017/6/1.
//  Copyright © 2017年 bingzaiJoker. All rights reserved.
//

#import "Waves.h"

@interface Waves (){
    CGFloat waveA;//水纹振幅
    CGFloat waveW ;//水纹周期
    CGFloat offsetX; //位移
    CGFloat currentK; //当前波浪高度Y
    CGFloat wavesSpeed;//水纹速度
    CGFloat WavesWidth; //水纹宽度
    CALayer * layer;
}
@property (nonatomic,strong)CADisplayLink *wavesDisplayLink;
@property (nonatomic,strong)CAShapeLayer *firstWavesLayer;
@property (nonatomic,strong)UIColor *firstWavesColor;
@end

@implementation Waves
+(instancetype)BzWaveWithFrame:(CGRect)fr Speed:(CGFloat)sp WaveA:(CGFloat)wa WaveW:(CGFloat)ww{
    Waves *temp =[[self alloc]initWithFrame:fr];
    temp->wavesSpeed = sp;
    temp->waveA = wa;
    temp->waveW = ww;
    return temp;
}

/*
 y =Asin（ωx+φ）+C
 A表示振幅，也就是使用这个变量来调整波浪的高度
 ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
 φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
 C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
 */

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        [self setUpWaves];
    }
    return self;
}

- (void)setUpWaves{
    //设置波浪的宽度
    WavesWidth = self.frame.size.width;
    //第一个波浪颜色
    self.firstWavesColor = [UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:255.0f/255.0f alpha:1];
    //初始化layer
    if (self.firstWavesLayer == nil) {
        //初始化
        self.firstWavesLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        self.firstWavesLayer.fillColor = self.firstWavesColor.CGColor;
        [self.layer addSublayer:self.firstWavesLayer];
        
    }
    if (wavesSpeed == 0.0f || waveA == 0.0f || waveW == 0.0f) {
        //设置波浪流动速度
        wavesSpeed = 0.08;
        //设置振幅
        waveA = 10;
        //设置周期
        waveW = 1.5/30.0;
    }
    //设置波浪纵向位置
    currentK = self.frame.size.height/2;//屏幕居中
    //启动定时器
    self.wavesDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [self.wavesDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)getCurrentWave:(CADisplayLink *)displayLink{
    //实时的位移
    offsetX += wavesSpeed;
    [self setCurrentFirstWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath{
    
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger i =0.0f; i<=WavesWidth; i++) {
        //正弦函数波浪公式
        y = waveA * sin(waveW * i+ offsetX)+currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, WavesWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.firstWavesLayer.path = path;
    CGPathRelease(path);
}

- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

-(void)dealloc
{
    [self.wavesDisplayLink invalidate];
}

@end
