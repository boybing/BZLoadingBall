//
//  LoadingBall.h
//  loading
//
//  Created by 冰仔 on 2017/5/27.
//  Copyright © 2017年 bingzaiJoker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingBall : UIScrollView
+(instancetype)BzGetLoadingBallWithFrame:(CGPoint)point AndWidth:(CGFloat)wid;
-(void)loadBallPercent:(CGFloat)pi;
@end
