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

    deinit {
        self.collectionView!.removeObserver(self, forKeyPath: "frame")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))

        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "GoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        var layout = self.collectionView!.collectionViewLayout as UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        
        //监听frame变化，修改cell的大小
        self.collectionView!.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
        
        // Do any additional setup after loading the view.
        self.showActivityIndicator()
        var param = Dictionary<String, AnyObject>()
        param["strDate"] = Utility.dateStr()
        param["strRow"] = 1
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/o_f", parameters: param, success: { (operation, responseObject) -> Void in
            self.hideActivityIndicator()
            
            var retDic = responseObject as [String : AnyObject]
            if retDic["rs"] != nil && retDic["rs"]!.isEqual("SUCCESS") {
                var goodData = GoodEntity(dictionary: retDic["entTg"] as Dictionary, error: nil)
                self.collectionData.append(goodData)
                self.collectionView!.reloadData()
            } else {
                NSLog("返回数据错误")
            }
        }, failure: { (operation, error) -> Void in
            self.hideActivityIndicator()
            
            NSLog("请求返回错误:%@", error)
        })
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

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as GoodCollectionViewCell
    
        cell.fulfillData = collectionData[indexPath.item]
    
        return cell
    }

}
