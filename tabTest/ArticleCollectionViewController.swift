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
    
    deinit {
        self.collectionView!.removeObserver(self, forKeyPath: "frame")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))

        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "Article2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        var layout = self.collectionView!.collectionViewLayout as UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        
        //监听frame变化，修改cell的大小
        self.collectionView!.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
        
        //网络请求
        var param = Dictionary<String, AnyObject>()
        param["strDate"] = "2015-06-09"
        param["strRow"] = 1
        param["strMS"] = 1
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/getC_N", parameters: param, success: { (operation, responseObject) -> Void in
            var retDic = responseObject as [String : AnyObject]
            if retDic["result"] != nil && retDic["result"]!.isEqual("SUCCESS") {
                var articleData = ArticleEntity(dictionary: retDic["contentEntity"] as Dictionary, error: nil)
                self.collectionData.append(articleData)
                self.collectionView!.reloadData()
            } else {
                NSLog("返回数据错误")
            }
        }) { (operation, error) -> Void in
                NSLog("请求返回错误:%@", error)
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as Article2CollectionViewCell
    
        cell.fulfillData = collectionData[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
