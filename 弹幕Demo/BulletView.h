//
//  BulletView.h
//  弹幕Demo
//
//  Created by JoyTomi on 2016/11/14.
//  Copyright © 2016年 JoyTomi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MoveStatus) {
    Start,
    Enter,
    End
};
@interface BulletView : UIView
//弹道
@property(nonatomic,assign)int trajectory;
@property(nonatomic,copy)void(^moveStatusBlock)(MoveStatus status);//弹幕的状态h回调

//初始化
-(instancetype)initWithComment:(NSString *)comment;

-(void)startAnimation;

-(void)stopAnimation;


@end
