//
//  GoodCollectionViewController.swift
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class GoodCollectionViewController: UICollectionViewController {

    let reuseIdentifier = "GoodCell"
    
    var collectionData = [GoodEntity]()

    var page : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        self.addNavigationBarRightItemWithName(nil, imageName: "threeDot", highlightImageName: "threeDot_hl", target: nil, action: nil)

        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "GoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        layout.footerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        
        // Do any additional setup after loading the view.
        self.requestGoodData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 修正collectionview layout
        let frame = self.collectionView!.frame
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        layout.headerReferenceSize = CGSize(width: frame.size.width, height: 0)
        layout.footerReferenceSize = CGSize(width: frame.size.width, height: 0)
    }

    func requestGoodData() {
        // request DB cache data
        let dateKey = Utility.dateStrBackStep(page - 1)
        let localData = DBOperation.queryRecord(TableName_one.Good, pk: dateKey)
        if let localData = localData {
            do {
                ++self.page
                let goodData = try GoodEntity(dictionary: localData)
                self.collectionData.append(goodData)
                self.collectionView!.reloadData()
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                })
                return
            } catch {
                NSLog("数据库数据格式错误")
            }
        }
        
        // make network request
        self.showActivityIndicator()
        
        var param = Dictionary<String, AnyObject>()
        param["strDate"] = Utility.dateStr()
        param["strRow"] = page
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/o_f", parameters: param, success: { (operation, responseObject) -> Void in
            self.hideActivityIndicator()
            
            var retDic = responseObject as! [String : AnyObject]
            if retDic["rs"] != nil && retDic["rs"]!.isEqual("SUCCESS") {
                do {
                    ++self.page
                    let goodData = try GoodEntity(dictionary: retDic["entTg"] as! Dictionary)
                    self.collectionData.append(goodData)
                    self.collectionView!.reloadData()
                    
                    DBOperation.insertRecord(TableName_one.Good, pk: dateKey, record: retDic["entTg"] as! Dictionary)
                } catch {
                    NSLog("返回数据格式错误")
                }
            } else {
                NSLog("返回数据错误")
            }
            if self.collectionData.count > 0 {
                self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            }
            }, failure: { (operation, error) -> Void in
                self.hideActivityIndicator()
                
                if self.collectionData.count > 0 {
                    self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
                }
                NSLog("请求返回错误:%@", error)
        })
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GoodCollectionViewCell
    
        cell.fulfillData = collectionData[indexPath.item]
    
        return cell
    }
    
    // MARK: scrollView delegate
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        if page == self.collectionData.count + 1 {
            self.requestGoodData()
        } else if page == 0 {
            self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
            self.showToast("已是最新内容")
        }
    }
    
}
