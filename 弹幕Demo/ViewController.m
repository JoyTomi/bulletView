//
//  ViewController.m
//  弹幕Demo
//
//  Created by JoyTomi on 2016/11/14.
//  Copyright © 2016年 JoyTomi. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
@interface ViewController ()
@property(nonatomic,strong)BulletManager *mgr;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.mgr = [[BulletManager alloc] init];
    __weak typeof (self)weakSelf = self;
    self.mgr.generateViewBlock = ^(BulletView *view){
        [weakSelf addBulletView:view];
    };
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(130, 10, 100, 30)];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(ClickStop) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBtn{
    [self.mgr start];
}

-(void)ClickStop{
    [self.mgr stop];
}

-(void)addBulletView:(BulletView *)view{
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(screenWidth, 300+view.trajectory*40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
