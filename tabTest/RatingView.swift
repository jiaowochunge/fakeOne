//
//  RatingView.swift
//  tabTest
//
//  Created by 王益 on 15/5/12.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class RatingView: UIControl {
    
    //有效分图片
    @IBInspectable var enableImage : UIImage!
    //无效分图片
    @IBInspectable var disableImage : UIImage?
    //最大分数
    @IBInspectable var maxCount : UInt = 0
    //评分图片大小。设置为0时，将用enableImage的宽度代替
    @IBInspectable var eleWidth : UInt = 0
    //是否允许编辑评分
    @IBInspectable var allowEdit : Bool = false
    
    //是否打分只支持整数
    var decimalOnly = false
    
    //分数
    var rateScore : Float = 0 {
        didSet {
            if rateScore > Float(maxCount) {
                //打分为整数
                rateScore = Float(maxCount)
            } else if rateScore < 0 {
                rateScore = 0
            } else {
                if decimalOnly {
                    rateScore = round(rateScore)
                }
            }
            self.setNeedsDisplay()
        }
    }
    
    let NBRINSET : CGFloat = 2.0

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        var ctx = UIGraphicsGetCurrentContext()
        //翻转坐标系
        CGContextTranslateCTM(ctx, 0.0, rect.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        //评分元素大小
        var eleWidth : CGFloat = CGFloat(self.eleWidth)
        var eleHeight : CGFloat = CGFloat(self.eleWidth)
        if self.eleWidth == 0 {
            eleWidth = self.enableImage.size.width
            eleHeight = self.enableImage.size.height
        }
        for var i : UInt = 0; i != maxCount; ++i {
            var imgFrame = CGRectMake(NBRINSET + (NBRINSET + eleWidth) * CGFloat(i), NBRINSET, eleWidth, eleHeight);
            var score : Float = rateScore - Float(i);
            if (score >= 1) {
                //全亮星星
                CGContextDrawImage(ctx, imgFrame, enableImage.CGImage);
            } else if (score > 0) {
                //亮部
                //这个cgWidth，貌似跟分辨率有关，高清屏幕下是eleWidth的2倍3倍
                var cgWidth = CGImageGetWidth(enableImage.CGImage);
                var cgHeight = CGImageGetHeight(enableImage.CGImage);
                var lightFrame = CGRectMake(NBRINSET + (NBRINSET + eleWidth) * CGFloat(i), NBRINSET, eleWidth * CGFloat(score), eleHeight);
                var imgRect = CGRectMake(0, 0, CGFloat(cgWidth) * CGFloat(score), CGFloat(cgHeight));
                var lightImg = CGImageCreateWithImageInRect(enableImage.CGImage, imgRect);
                CGContextDrawImage(ctx, lightFrame, lightImg);
                //暗部
                if disableImage != nil {
                    var darkFrame = CGRectMake(NBRINSET + (NBRINSET + eleWidth) * CGFloat(i) + eleWidth * CGFloat(score), NBRINSET, eleWidth * CGFloat(1 - score), eleHeight);
                    imgRect = CGRectMake(CGFloat(cgWidth) * CGFloat(score), 0, CGFloat(cgWidth) * CGFloat(1 - score), CGFloat(cgHeight));
                    var darkImg = CGImageCreateWithImageInRect(disableImage!.CGImage, imgRect);
                    CGContextDrawImage(ctx, darkFrame, darkImg);
                }
            } else {
                //全暗星星
                if disableImage != nil {
                    CGContextDrawImage(ctx, imgFrame, disableImage!.CGImage);
                }
            }
        }
    }
    
    func processTouches(touch : UITouch) {
        var pt : CGPoint = touch.locationInView(self)
        var elementWidth : CGFloat = CGFloat(eleWidth);
        if (elementWidth == 0) {
            elementWidth = enableImage.size.width;
        }
        var score : CGFloat = (pt.x - NBRINSET) / (elementWidth + NBRINSET);
        rateScore = Float(score)
    }
    
    override func intrinsicContentSize() -> CGSize {
        if (eleWidth != 0) {
            return CGSizeMake((NBRINSET + CGFloat(eleWidth)) * CGFloat(maxCount) + NBRINSET, NBRINSET * 2 + CGFloat(eleWidth));
        } else {
            return CGSizeMake((NBRINSET + enableImage.size.width) * CGFloat(maxCount) + NBRINSET, NBRINSET * 2 + enableImage.size.height);
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        if allowEdit {
            self.processTouches(touch)
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
            return true
        } else {
            return false
        }
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        if allowEdit {
            self.processTouches(touch)
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
            return true
        } else {
            return false
        }
    }

}
