//
//  NBRateView.h
//  Ufingernail
//
//  Created by john on 14-12-17.
//  Copyright (c) 2014年 ___coco-sh___. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface NBRateView : UIView

@property (nonatomic) IBInspectable UIImage *enableImage;
@property (nonatomic) IBInspectable UIImage *disableImage;
@property (nonatomic) IBInspectable NSUInteger maxCount;
@property (nonatomic) IBInspectable NSUInteger eleWidth;
@property (nonatomic) IBInspectable BOOL allowEdit;
@property (nonatomic, assign) CGFloat rateScore;

- (void)setTarget:(id)target forValueChangeAction:(SEL)action;

@end
