
//
//  BulletManager.m
//  弹幕Demo
//
//  Created by JoyTomi on 2016/11/14.
//  Copyright © 2016年 JoyTomi. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"
@interface BulletManager()
//数据源 弹幕
@property(nonatomic,strong)NSMutableArray *dataSource;
//弹幕使用过程中的数据变量
@property(nonatomic,strong)NSMutableArray *bulletComments;
//存贮弹幕View的数组变量
@property(nonatomic,strong)NSMutableArray *bulletViews;
@property BOOL bStopAnimation;

@end
@implementation BulletManager

-(instancetype)init{
    if ([super init]) {
        _bStopAnimation = YES;
    }
    return self;
}

-(void)start{
    if (!self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];
    [self initBulletComment];
}

//初始化弹幕，随机分配弹幕路径
-(void)initBulletComment{
    //通过随机数组获取弹幕轨迹
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (int i = 0; i<3; i++) {
        if (self.bulletComments.count > 0) {
            NSInteger index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            //从弹幕数组中取出弹幕数据
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            [self createBulletView:comment trajectory:trajectory];
        }
    }
}

-(void)createBulletView:(NSString *)comment trajectory:(int)tracjectory{
    if (self.bStopAnimation) {
        return;
    }
    BulletView *view = [[BulletView alloc] initWithComment:comment];
    view.trajectory = tracjectory;
    __weak typeof (view) weakView = view;
    __weak typeof (self)weakSelf = self;
    [self.bulletViews addObject:view];
    view.moveStatusBlock = ^(MoveStatus status){
        if (self.bStopAnimation) {
            return ;
        }
        switch (status) {
            case Start:
                //弹幕开始进入屏幕，将view加入到弹幕管理变量中
                [weakSelf.bulletViews addObject:weakView];
                break;
                
            case Enter:
                //弹幕完全进入屏幕，判断是否还有其他内容，如果有在该弹幕轨迹中创建弹幕
            {
                NSString *comment = [weakSelf nextComment];
                if (comment) {
                    [weakSelf createBulletView:comment trajectory:tracjectory];
                }
            }
                
                break;
                
            case End:
                //弹幕完全飞出后
                if([weakSelf.bulletViews containsObject:weakView]){
                    [weakView stopAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                
                }
                if (weakSelf.bulletViews.count == 0) {
                    weakSelf.bStopAnimation = YES;
                    [weakSelf start];
                }
                
                break;
            default:
                break;
        }
    };
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
}


-(NSString *)nextComment{
    if (self.bulletComments.count == 0) {
        return nil;
    }
    NSString *comment = [self.bulletComments firstObject];
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}

-(void)stop{
    if (self.bStopAnimation) {
        return;
    }
    
    self.bStopAnimation = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimation];
        view  = nil;
    }];
    
    [self.bulletViews removeAllObjects];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕111111111111111111111111111",@"弹幕^^*1232",@"弹幕3",@"弹幕4ooooo",@"弹幕5ppppp"]];
    }
    return _dataSource;
}

-(NSMutableArray *)bulletComments{
    if (!_bulletComments) {
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

-(NSMutableArray *)bulletViews{
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}



@end
