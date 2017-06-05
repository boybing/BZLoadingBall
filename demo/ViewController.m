//
//  ViewController.m
//  loading
//
//  Created by 冰仔 on 2017/5/27.
//  Copyright © 2017年 bingzaiJoker. All rights reserved.
//

#import "ViewController.h"
#import "LoadingBall.h"

@interface ViewController (){
    LoadingBall *ball;
}

@end

@implementation ViewController
- (IBAction)sd:(UISlider *)sender {
    [ball loadBallPercent:sender.value];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ball = [LoadingBall BzGetLoadingBallWithFrame:CGPointMake(100, 100) AndWidth:200];
//    ball = [[LoadingBall alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:ball];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
