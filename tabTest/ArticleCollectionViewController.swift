//
//  ArticleCollectionViewController.swift
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class ArticleCollectionViewController: UICollectionViewController {

    let reuseIdentifier = "ArticleCell"

    var collectionData = [ArticleEntity]()
    
    var page : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        self.addNavigationBarRightItemWithName(nil, imageName: "threeDot", highlightImageName: "threeDot_hl", target: nil, action: nil)

        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "Article2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        layout.footerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        
        self.requestAticleData()
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
    
    //网络请求
    func requestAticleData() {
        self.showActivityIndicator()
        
        var param = Dictionary<String, AnyObject>()
        param["strDate"] = Utility.dateStr()
        param["strRow"] = page
        param["strMS"] = 1
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/getC_N", parameters: param, success: { (operation, responseObject) -> Void in
            self.hideActivityIndicator()
            
            var retDic = responseObject as! [String : AnyObject]
            if retDic["result"] != nil && retDic["result"]!.isEqual("SUCCESS") {
                do {
                    ++self.page
                    let articleData = try ArticleEntity(dictionary: retDic["contentEntity"] as! Dictionary)
                    self.collectionData.append(articleData)
                    self.collectionView!.reloadData()
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Article2CollectionViewCell
    
        cell.fulfillData = collectionData[indexPath.item]
    
        return cell
    }

    // MARK: scrollView delegate
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        if page == self.collectionData.count + 1 {
            self.requestAticleData()
        } else if page == 0 {
            self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
            self.showToast("已是最新内容")
        }
    }
}
