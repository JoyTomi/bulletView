//
//  BulletManager.h
//  弹幕Demo
//
//  Created by JoyTomi on 2016/11/14.
//  Copyright © 2016年 JoyTomi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BulletView.h"
@interface BulletManager : NSObject
@property(nonatomic,copy)void(^generateViewBlock)(BulletView *view);

//弹幕开始执行
-(void)start;
//弹幕停止执行
-(void)stop;
@end
