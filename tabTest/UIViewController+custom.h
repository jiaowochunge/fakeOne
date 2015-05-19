//
//  UIViewController+custom.h
//  tabTest
//
//  Created by john on 15/4/29.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (custom)

+ (void)customTabbar;

+ (void)customNavigationBar;

- (void)addNavigationBarRightItemWithName:(NSString *)text ImageName:(NSString *)imageName Target:(id)target Action:(SEL)selector;

@end
