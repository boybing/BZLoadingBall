//
//  LoadingBall.m
//  loading
//
//  Created by 冰仔 on 2017/5/27.
//  Copyright © 2017年 bingzaiJoker. All rights reserved.
//

#import "LoadingBall.h"
#import "Waves.h"
#import "colorNumber.h"
@interface LoadingBall(){
    CGFloat viewLoadX;
    CGFloat _wid;
    LoadingBall *lb;
    Waves *wv;
    Waves *wwv;
    colorNumber * cr;
}
@end
@implementation LoadingBall
- (instancetype)initWithFrame:(CGRect)frame
{
    [self exp];
    return nil;
}

- (instancetype)init
{
    [self exp];
    return nil;
}

+(instancetype)new{
    [[LoadingBall alloc ]exp];
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    [self exp];
    return nil;
}

-(void)exp{
    //异常的名称
    NSString *exceptionName = @"method using problem";
    //异常的原因
    NSString *exceptionReason = @"you should use the method 'BzGetLoadingBallWithFrame: AndWidth:' to creat the object";
    //异常的信息
    NSDictionary *exceptionUserInfo = nil;
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];
    //抛异常
    @throw exception;
}



- (instancetype)initWithFrameBall:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _wid = frame.size.width;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:255.0f/255.0f alpha:1].CGColor;
        self.layer.masksToBounds = YES;
        self.contentSize = CGSizeMake(_wid, 2 * _wid);
        self.layer.cornerRadius = _wid/2;
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        [self SetUI];
        lb= self;
    }
    return self;
}

-(void)SetUI{
    wv = [Waves BzWaveWithFrame:CGRectMake(0, 0, _wid, 2 * _wid) Speed:0.08 WaveA:10 WaveW:1.5/30.0];
    wv.alpha = 0.6;
    [self addSubview:wv];
    
    wwv = [Waves BzWaveWithFrame:CGRectMake(0, 0, _wid, 2 * _wid) Speed:0.09 WaveA:12 WaveW:1.5/30.0];
    wwv.alpha = 0.6;
    [self addSubview:wwv];
    
    cr = [[colorNumber alloc]initWithFrame:CGRectMake(0, 0, _wid, 2*_wid)];
    [cr.colorLabel setFrame:CGRectMake(0, -0.5*_wid, cr.colorLabel.frame.size.width, cr.colorLabel.frame.size.height)];
    [self addSubview:cr];
    
}

+(instancetype)BzGetLoadingBallWithFrame:(CGPoint)point AndWidth:(CGFloat)wid{
    return [[LoadingBall alloc]initWithFrameBall:CGRectMake(point.x, point.y, wid, wid)];
}

-(void)loadBallPercent:(CGFloat)pi{
    lb.contentOffset = CGPointMake(0, (pi / 100) * _wid);
    cr.colorLabel.frame = CGRectMake(0, -0.5*_wid+(pi / 100) * _wid, cr.colorLabel.frame.size.width, cr.colorLabel.frame.size.height);
    cr.colorLabel.text = [NSString stringWithFormat:@"%.f%@", (pi / 100)*100,@"%"];
}
@end
