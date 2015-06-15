//
//  UIViewController+custom.m
//  tabTest
//
//  Created by john on 15/4/29.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "UIViewController+custom.h"

@implementation UIViewController (custom)

- (void)customTabbarItems
{
    NSArray *items = self.tabBarController.tabBar.items;
    for (NSInteger i = 1; i != 6; ++i) {
        UITabBarItem *item = [items objectAtIndex:i - 1];
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"item%ld", (long)i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"item%ld_hl", (long)i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = nil;
        if (i == 1 || 1) {
//            item.imageInsets = UIEdgeInsetsMake(3, 0, -10, 0);
        }
    }
}

+ (void)customTabbar
{
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarBG"]];
    [[UITabBar appearance] setShadowImage:[UIViewController clearImage]];
}

+ (void)customNavigationBar
{
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationBarBG"]]];
    [[UINavigationBar appearance] setShadowImage:[UIViewController clearImage]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarBG"] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)addNavigationBarRightItemWithName:(NSString *)text ImageName:(NSString *)imageName Target:(id)target Action:(SEL)selector
{
    
}

+ (UIImage *)clearImage
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
