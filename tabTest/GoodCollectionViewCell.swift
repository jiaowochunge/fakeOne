//
//  GoodCollectionViewCell.swift
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class GoodCollectionViewCell: UICollectionViewCell {
    
    //日期
    @IBOutlet var date : UILabel!
    //东西图片
    @IBOutlet var goodImage : UIImageView!
    
    @IBOutlet var goodImageRatioConstraint : NSLayoutConstraint!
    //东西名称
    @IBOutlet var goodName : UILabel!
    //东西介绍
    @IBOutlet var goodBrief : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        goodImage.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGoodImage:")
        goodImage.addGestureRecognizer(tapGesture)
    }
    
    var fulfillData : GoodEntity! {
        didSet {
            weak var weakSelf : GoodCollectionViewCell! = self

            date.text = fulfillData.strDate
            goodImage.sd_setImageWithURL(NSURL(string: fulfillData.strBu), completed: { (image : UIImage!, error : NSError!, type : SDImageCacheType, url : NSURL!) -> Void in
                if error == nil {
                    weakSelf.goodImageRatioConstraint.constant = weakSelf.goodImage.frame.size.width - image.size.height * weakSelf.goodImage.frame.size.width * weakSelf.goodImageRatioConstraint.multiplier / image.size.width;

                    weakSelf.setNeedsUpdateConstraints()
                    weakSelf.layoutIfNeeded()
                }
            })
            goodName.text = fulfillData.strTt
            goodBrief.text = fulfillData.strTc
        }
    }
    
    //点击图片事件
    @IBAction func tapGoodImage(gesture : UIGestureRecognizer) {
        let url = NSURL(string: fulfillData.strWu)
        if url != nil {
            UIApplication.sharedApplication().openURL(url!)
        }
    }

}
