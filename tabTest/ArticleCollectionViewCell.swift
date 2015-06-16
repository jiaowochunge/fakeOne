//
//  ArticleCollectionViewCell.swift
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

/**
* 此文件废弃。这个cell由scrollview实现，正文部分是个多行label。测试发现无法满足需求，多行label最大支持489行，再多系统不予绘制。（自己测试的结果）
* 改用tableview实现。重用提高性能
*/
class ArticleCollectionViewCell: UICollectionViewCell {
    //日期
    @IBOutlet var dateLabel : UILabel!
    //观看人数
    @IBOutlet var viewNum : UILabel!
    //题目
    @IBOutlet var articleTitle : UILabel!
    //作者
    @IBOutlet var author1 : UILabel!
    //正文
    @IBOutlet var articleContent : UILabel!
    //尾巴
    @IBOutlet var articleTail : UILabel!
    //喜欢按钮
    @IBOutlet var likeButton : UIButton!
    //作者
    @IBOutlet var author2 : UILabel!
    //作者网上资料
    @IBOutlet var authorNW : UILabel!
    //作者介绍
    @IBOutlet var authorBrief : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var fulfillData : ArticleEntity! {
        didSet {
            
            dateLabel.text = fulfillData.strDate;
            viewNum.text = fulfillData.sRdNum;
            articleTitle.text = fulfillData.strContTitle
            author1.text = fulfillData.strContAuthor
            
            articleContent.text = fulfillData.processedContent
            articleTail.text = fulfillData.strContAuthorIntroduce
            likeButton.setTitle(fulfillData.strPraiseNumber, forState: UIControlState.Normal)
            author2.text = fulfillData.strContAuthor
            authorNW.text = fulfillData.sWbN
            authorBrief.text = fulfillData.sAuth
            
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        authorBrief.preferredMaxLayoutWidth = authorBrief.bounds.size.width
        articleContent.preferredMaxLayoutWidth = articleContent.bounds.size.width
    }
    
}
