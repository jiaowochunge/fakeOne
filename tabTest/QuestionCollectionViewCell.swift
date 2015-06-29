//
//  QuestionCollectionViewCell.swift
//  tabTest
//
//  Created by john on 15/6/16.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    //日期
    @IBOutlet var dateStr : UILabel!
    //问题
    @IBOutlet var question : UILabel!
    //问题描述
    @IBOutlet var questionDetail : UILabel!
    //回答
    @IBOutlet var answer : UILabel!
    //回答描述
    @IBOutlet var answerDetailTable : UITableView!
    //结尾
    @IBOutlet var tail : UILabel!
    //点赞
    @IBOutlet var likeButton : UIButton!
    
    var tableData = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var fulfillData : QuestionEntity! {
        didSet {
            dateStr.text = fulfillData.strDate
            question.text = fulfillData.strQuestionTitle
            questionDetail.text = fulfillData.strQuestionContent
            answer.text = fulfillData.strAnswerTitle
            tail.text = fulfillData.sEditor
            likeButton.setTitle(fulfillData.strPraiseNumber, forState: UIControlState.Normal)
            
            let tableHeader = answerDetailTable.tableHeaderView!
            let height = tableHeader.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            var frame = tableHeader.frame
            frame.size.height = height
            tableHeader.frame = frame
            //这句话很重要。没有下面这句话，虽然tableHeader的大小是重置了，但tableHeader可能遮盖下面的内容
            answerDetailTable.tableHeaderView = tableHeader;
            
            //回答内容
            var tmpArr = Array<String>()
            for line : AnyObject in fulfillData.lineArr {
                tmpArr.append(line as! String)
            }
            tableData = tmpArr
            answerDetailTable.reloadData()
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let lineContent = tableData[indexPath.row]
        
        let hehe = NSString(string: lineContent)
        
        let labelProperty = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
        let frame = hehe.boundingRectWithSize(CGSizeMake(self.bounds.size.width - 30, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: labelProperty, context: nil)
        
        return max(frame.size.height + 5, 15)
    }

}
