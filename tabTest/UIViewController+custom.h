//
//  UIViewController+custom.h
//  tabTest
//
//  Created by john on 15/4/29.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (custom)

/** 设置标签栏各个选项卡
 */
- (void)customTabbarItems;

/** 设置标签栏背景图
 */
+ (void)customTabbar;

/** 设置导航栏背景图
 */
+ (void)customNavigationBar;

- (void)addNavigationBarRightItemWithName:(NSString *)text ImageName:(NSString *)imageName Target:(id)target Action:(SEL)selector;

@end
