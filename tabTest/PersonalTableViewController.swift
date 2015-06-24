//
//  PersonalTableViewController.swift
//  tabTest
//
//  Created by john on 15/4/29.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class PersonalTableViewController: UITableViewController {
    
    var tableData : Array<Dictionary<String, AnyObject>>?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        self.tableView.tableFooterView = UIView();
        tableData = [["image" : "http://pic.baike.soso.com/p/20130627/20130627103947-896322375.jpg", "text" : "糗事百科指各种最最尴尬事情的总汇，那份尴尬的心情真是叫人哭笑不得", "url" : "http://www.qiushibaike.com"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 3 {
            return 1
        } else {
            if tableData == nil {
                return 0
            } else {
                return tableData!.count
            }
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        if indexPath.section < 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("setting", forIndexPath: indexPath) as UITableViewCell
            if indexPath.section == 0 {
                cell.imageView?.image = UIImage(named: "loginIcon")
                cell.textLabel?.text = "欢迎加入"
            } else {
                cell.imageView?.image = UIImage(named: "settingIcon")
                cell.textLabel?.text = "设置"
            }
            cell.userInteractionEnabled = false
        } else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("recomend", forIndexPath: indexPath) as UITableViewCell
            cell.userInteractionEnabled = false
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("app", forIndexPath: indexPath) as UITableViewCell
            
            var imageView = cell.viewWithTag(21) as UIImageView
            var label = cell.viewWithTag(22) as UILabel
            
            var cellData = tableData![indexPath.row]
            
            if let url = NSURL(string: cellData["image"] as String) {
                imageView.sd_setImageWithURL(url)
            }
            label.text = cellData["text"] as? String
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var cellData = tableData![indexPath.row]
        self.pushWebView(cellData["url"] as String)
    }

}
