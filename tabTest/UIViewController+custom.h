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

- (void)customNavigationBackButton;

- (void)addNavigationBarRightItemWithName:(NSString *)text ImageName:(NSString *)imageName HighlightImageName:(NSString *)highlightImageName Target:(id)target Action:(SEL)selector;

+ (UIImage *)clearImage;

/** 加个菊花
 */
- (void)showActivityIndicator;

/** 去掉菊花
 */
- (void)hideActivityIndicator;

/** 吐司三兄弟
 */
- (void)showToast:(NSString *)message;

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration;

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration onComplete:(void(^)(BOOL finish))complete;

- (void)pushWebView:(NSString *)urlStr;

@end
