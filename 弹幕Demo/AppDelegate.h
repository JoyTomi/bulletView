//
//  AppDelegate.h
//  弹幕Demo
//
//  Created by JoyTomi on 2016/11/14.
//  Copyright © 2016年 JoyTomi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

