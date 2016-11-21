
//
//  BulletView.m
//  弹幕Demo
//
//  Created by JoyTomi on 2016/11/14.
//  Copyright © 2016年 JoyTomi. All rights reserved.
//

#import "BulletView.h"
#define Padding 10
@interface BulletView()
@property(nonatomic,strong)UILabel *lbComment;
@end
@implementation BulletView

-(instancetype)initWithComment:(NSString *)comment{
    if ([super init]) {
        self.backgroundColor = [UIColor redColor];
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        //计算弹幕的实际宽度
        CGFloat width = [comment sizeWithAttributes:dict].width;
        self.bounds = CGRectMake(0, 0, width+2*Padding, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding, 0, width, 30);
    }

    return self;
}


-(void)startAnimation{
    //根据弹幕长度执行动画效果
    //v = s/t;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    //弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    //计算
    CGFloat duration = 4.0;
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.moveStatusBlock(Enter);
//    });//无法停止所以换方法
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
    
}

-(void)enterScreen{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

-(void)stopAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}


-(UILabel *)lbComment{
    if (!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = 1;
        [self addSubview:_lbComment];
        
    }
    return _lbComment;
}

@end
