//
//  HomeCollectionViewCell.swift
//  tabTest
//
//  Created by john on 15/6/9.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    //卷号
    @IBOutlet var volumeNo : UILabel!
    //题图
    @IBOutlet var workImage : UIImageView!
    
    @IBOutlet var workImageRatioConstraint : NSLayoutConstraint!
    //作品名称
    @IBOutlet var workName : UILabel!
    //作者
    @IBOutlet var workAuthor : UILabel!
    //日期
    @IBOutlet var dayLabel : UILabel!
    //年月
    @IBOutlet var dateLabel : UILabel!
    //卷首语
    @IBOutlet var workBrief : UILabel!
    //点赞
    @IBOutlet var likeIt : UIButton!
    
    var fulfillData : HomepageEntity! {
        didSet {
            weak var weakSelf : HomeCollectionViewCell! = self
            
            volumeNo.text = fulfillData.strHpTitle
            workImage.sd_setImageWithURL(NSURL(string: fulfillData.strThumbnailUrl), completed: { (image : UIImage!, error : NSError!, type : SDImageCacheType, url : NSURL!) -> Void in
                if error == nil {
                    weakSelf.workImageRatioConstraint.constant = image.size.width / image.size.height
                }
            })
            workName.text = fulfillData.strWorkName
            workAuthor.text = fulfillData.strWorkAuthor
            dayLabel.text = fulfillData.strDay
            dateLabel.text = fulfillData.strMonthYear
            workBrief.text = fulfillData.strContent
            likeIt.setTitle(fulfillData.strPn, forState: UIControlState.Normal)
            
            self.updateConstraintsIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        workBrief.preferredMaxLayoutWidth = workBrief.bounds.size.width
    }

}
