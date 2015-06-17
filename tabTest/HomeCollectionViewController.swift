//
//  HomeCollectionViewController.swift
//  tabTest
//
//  Created by john on 15/6/9.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {
    
    let homeReuseIdentifier = "HomeCell"

    var collectionData = [HomepageEntity]()
    
    var page : Int = 1
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        UIViewController.customNavigationBar()
        UIViewController.customTabbar()
    }
    
    deinit {
        self.collectionView!.removeObserver(self, forKeyPath: "frame")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customTabbarItems()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        self .addNavigationBarRightItemWithName(nil, imageName: "threeDot", target: self, action: "rightButtonAction:")
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: homeReuseIdentifier)
        self.collectionView!.registerNib(UINib(nibName: "EmptyCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView!.registerNib(UINib(nibName: "EmptyCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")

        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        var layout = self.collectionView!.collectionViewLayout as UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        layout.footerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        
        //监听frame变化，修改cell的大小
        self.collectionView!.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
        // Do any additional setup after loading the view.
        
        self.requestHomePageData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            //监听collectionView.frame的变化。经过测试，此处监听bounds属性无效
            var frame = CGRectZero
            if let value = change["new"] as? NSValue {
                frame = value.CGRectValue()
                
                var layout = self.collectionView!.collectionViewLayout as UICollectionViewFlowLayout
                layout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
                layout.headerReferenceSize = CGSize(width: frame.size.width, height: 0)
                layout.footerReferenceSize = CGSize(width: frame.size.width, height: 0)
            }
        }
    }
    
    //网络请求
    func requestHomePageData() {
        self.showActivityIndicator()
        
        var param = Dictionary<String, AnyObject>()
        param["strDate"] = Utility.dateStr()
        param["strRow"] = page
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/getHp_N", parameters: param, success: { (operation, responseObject) -> Void in
            self.hideActivityIndicator()

            var retDic = responseObject as [String : AnyObject]
            if retDic["result"] != nil && retDic["result"]!.isEqual("SUCCESS") {
                ++self.page
                var homeData = HomepageEntity(dictionary: retDic["hpEntity"] as Dictionary, error: nil)
                self.collectionData.append(homeData)
                self.collectionView!.reloadData()
            } else if retDic["result"] != nil && retDic["result"]!.isEqual("FAIL") {
                self.showToast("不提供更多资料，请上网站自己去看")
            } else {
                NSLog("返回数据错误")
            }
            self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            }) { (operation, error) -> Void in
                self.hideActivityIndicator()
                
                self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                NSLog("请求返回错误:%@", error)
        }
    }
    
    func rightButtonAction(sender : AnyObject) {
        // TODO: 有空来实现下
        var actionSheet = UIAlertController(title: "分享到", message: "然而，并不能高度定制", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        actionSheet.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            println("I see \(textField.text)")
        }
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(homeReuseIdentifier, forIndexPath: indexPath) as HomeCollectionViewCell
    
        cell.fulfillData = collectionData[indexPath.item]
    
        return cell
    }
    
    // MARK: scrollView delegate
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        if page == self.collectionData.count + 1 {
            self.requestHomePageData()
        } else if page == 0 {
            // TODO:
            self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
            self.showToast("已是最新内容")
        }
    }

}
