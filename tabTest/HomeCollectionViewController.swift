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
        
        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        var layout = self.collectionView!.collectionViewLayout as UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        
        //监听frame变化，修改cell的大小
        self.collectionView!.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
        // Do any additional setup after loading the view.
        
        var param = Dictionary<String, AnyObject>()
        param["strDate"] = Utility.dateStr()
        param["strRow"] = 1
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/getHp_N", parameters: param, success: { (operation, responseObject) -> Void in
            var retDic = responseObject as [String : AnyObject]
            if retDic["result"] != nil && retDic["result"]!.isEqual("SUCCESS") {
                var homeData = HomepageEntity(dictionary: retDic["hpEntity"] as Dictionary, error: nil)
                self.collectionData.append(homeData)
                self.collectionView!.reloadData()
            } else {
                NSLog("返回数据错误")
            }
        }) { (operation, error) -> Void in
            NSLog("请求返回错误:%@", error)
        }
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
            }
        }
    }
    
    func rightButtonAction(sender : AnyObject) {
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

}
