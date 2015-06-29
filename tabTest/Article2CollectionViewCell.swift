//
//  Article2CollectionViewCell.swift
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class Article2CollectionViewCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    //日期
    @IBOutlet var dateLabel : UILabel!
    //观看人数
    @IBOutlet var viewNum : UILabel!
    //题目
    @IBOutlet var articleTitle : UILabel!
    //作者
    @IBOutlet var author1 : UILabel!
    //正文
    @IBOutlet var contentTable : UITableView!
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
    
    var tableData = [String]()

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
            articleTail.text = fulfillData.strContAuthorIntroduce
            likeButton.setTitle(fulfillData.strPraiseNumber, forState: UIControlState.Normal)
            author2.text = fulfillData.strContAuthor
            authorNW.text = fulfillData.sWbN
            authorBrief.text = fulfillData.sAuth
            
            //正文内容
            
            var tmpArr = Array<String>()
            for line : AnyObject in fulfillData.lineArr {
                tmpArr.append(line as! String)
            }
            tableData = tmpArr
            contentTable.reloadData()
        }
    }
    
    // MARK: tableView delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("textCell") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "textCell")
            cell?.textLabel?.font = UIFont.systemFontOfSize(14)
            cell?.textLabel?.numberOfLines = 0
        }
        
        cell?.textLabel?.text = tableData[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let lineContent = tableData[indexPath.row]
        
        let hehe = NSString(string: lineContent)
        
        
        let labelProperty = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
        let frame = hehe.boundingRectWithSize(CGSizeMake(self.bounds.size.width - 30, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: labelProperty, context: nil)
        
        return max(frame.size.height + 5, 15)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

}
