//
//  UIViewController+custom.m
//  tabTest
//
//  Created by john on 15/4/29.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "UIViewController+custom.h"

@implementation UIViewController (custom)

const NSInteger ActivityTag = 997;

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
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];

    CGFloat buttonWidth = 10;
    if (imageName && imageName.length) {
        UIImage *image = [UIImage imageNamed:imageName];
        //image按高度或宽度40比例缩放
        if (image.size.width > image.size.height) {
            buttonWidth += image.size.height / image.size.width * 40;
        } else {
            buttonWidth += image.size.width / image.size.height * 40;
        }
        [rightButton setImage:image forState:UIControlStateNormal];
    }
    
    if (text && text.length) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(100, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
        buttonWidth += 5 + frame.size.width;
        [rightButton setTitle:text forState:UIControlStateNormal];
    }

    rightButton.frame = CGRectMake(0, 0, MAX(buttonWidth, 40), 40);
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
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

- (void)showActivityIndicator
{
    UIActivityIndicatorView *indicator = nil;
    if ([self.view viewWithTag:ActivityTag]) {
        indicator = (UIActivityIndicatorView *)[self.view viewWithTag:ActivityTag];
    } else {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
        indicator.tag = ActivityTag;
        indicator.hidesWhenStopped = YES;
        [self.view addSubview:indicator];
    }
    [indicator startAnimating];
}

- (void)hideActivityIndicator
{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self.view viewWithTag:ActivityTag];
    if (indicator) {
        [indicator stopAnimating];
    }
}

- (void)showToast:(NSString *)message
{
    [self showToast:message duration:1.6];
}

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showToast:message duration:duration onComplete:nil];
}

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration onComplete:(void (^)(BOOL finish))complete
{
    if (!message || !message.length) {
        return;
    }
    //吐司长度为200，多行显示
    CGRect frame = [message boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    UILabel *toast = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width + 20, frame.size.height + 10)];
    //文字居中
    toast.textAlignment = NSTextAlignmentCenter;
    toast.numberOfLines = 0;
    //边框圆角
    toast.layer.cornerRadius = 5;
    toast.layer.masksToBounds = YES;
    //背景色处理
    toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    toast.textColor = [UIColor whiteColor];
    //文字
    toast.font = [UIFont systemFontOfSize:14];
    toast.text = message;
    //初始位置
    toast.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 3 / 4);
    [self.view addSubview:toast];
    
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = toast.frame;
        frame.origin.y -= 30;
        toast.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:duration - 0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            toast.alpha = 0;
        }completion:^(BOOL finished) {
            [toast removeFromSuperview];
            if (finished) {
                if (complete) {
                    complete(YES);
                }
            } else {
                if (complete) {
                    complete(NO);
                }
            }
        }];
    }];
}

@end
