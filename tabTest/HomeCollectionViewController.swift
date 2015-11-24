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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        UIViewController.customTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customTabbarItems()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        self.addNavigationBarRightItemWithName(nil, imageName: "threeDot", highlightImageName: "threeDot_hl", target: self, action: "rightButtonAction:")
        
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: homeReuseIdentifier)
        self.collectionView!.registerNib(UINib(nibName: "EmptyCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView!.registerNib(UINib(nibName: "EmptyCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")

        //在autolayout机制下，无法获得正确的height，height在viewdidappear中才由autolayout计算出来
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 480)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        layout.footerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 0)
        
        // Do any additional setup after loading the view.
        
        self.requestHomePageData()
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
    func requestHomePageData() {
        // request DB cache data
        let dateKey = Utility.dateStrBackStep(page - 1)
        let localHomeData = DBOperation.queryRecord(TableName_one.HomePage, pk: dateKey)
        if let localHomeData = localHomeData {
            do {
                ++self.page
                let homeData = try HomepageEntity(dictionary: localHomeData)
                self.collectionData.append(homeData)
                self.collectionView!.reloadData()
                
                // 这个地方我也不知道怎么该。逻辑是，colletionview的header是个空白缓冲页，加载到数据后，不显示空白页，显示数据页。这里直接scroll貌似和reloadData的动作冲突了，异步晚些时间似乎就行了
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
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
        
        ApiClient.GET("http://bea.wufazhuce.com/OneForWeb/one/getHp_N", parameters: param, success: { (operation, responseObject) -> Void in
            self.hideActivityIndicator()

            var retDic = responseObject as! [String : AnyObject]
            if retDic["result"] != nil && retDic["result"]!.isEqual("SUCCESS") {
                do {
                    ++self.page
                    let homeData = try HomepageEntity(dictionary: retDic["hpEntity"] as! Dictionary)
                    self.collectionData.append(homeData)
                    self.collectionView!.reloadData()
                    
                    DBOperation.insertRecord(TableName_one.HomePage, pk: dateKey, record: retDic["hpEntity"] as! Dictionary)
                } catch {
                    NSLog("返回数据格式错误")
                }
            } else if retDic["result"] != nil && retDic["result"]!.isEqual("FAIL") {
                self.showToast("不提供更多资料，请上网站自己去看")
            } else {
                NSLog("返回数据错误")
            }
            // 修复数组越界。第一次请求失败时，数组为空，越界崩溃
            if self.collectionData.count > 0 {
                self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            }
            
            }) { (operation, error) -> Void in
                self.hideActivityIndicator()
                
                if self.collectionData.count > 0 {
                    self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.collectionData.count - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                }
                NSLog("请求返回错误:%@", error)
        }
    }
    
    func rightButtonAction(sender : AnyObject) {
        // TODO: 有空来实现下
        return
//        var actionSheet = UIAlertController(title: "分享到", message: "然而，并不能高度定制", preferredStyle: .Alert)
//        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
//        actionSheet.addAction(cancelAction)
//        actionSheet.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
//            println("I see \(textField.text)")
//        }
//        self.presentViewController(actionSheet, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(homeReuseIdentifier, forIndexPath: indexPath) as! HomeCollectionViewCell
    
        cell.fulfillData = collectionData[indexPath.item]
    
        return cell
    }
    
    // MARK: scrollView delegate
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        if page == self.collectionData.count + 1 {
            self.requestHomePageData()
        } else if page == 0 {
            // TODO:
            self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
            self.showToast("已是最新内容")
        }
    }

}
