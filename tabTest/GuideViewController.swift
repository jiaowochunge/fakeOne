//
//  GuideViewController.swift
//  one
//
//  Created by john on 15/6/17.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UIScrollViewDelegate {
    
    var onceLock : NSLock
    var hasOnce = false
    
    var pageControl : UIPageControl!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        onceLock = NSLock()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加scrollview作为容器
        let container = UIScrollView(frame: self.view.bounds)
        container.pagingEnabled = true
        container.delegate = self
        if let image = UIImage(named: "Launch_bgfor4") {
            container.backgroundColor = UIColor(patternImage: image)
        }
        self.view.addSubview(container)
        
        //添加各个imageView
        let guideImageName = ["Launch_1for4", "Launch_2for4", "Launch_3for4", "Launch_4for4", "Launch_5for4"]
        let imageWidth = self.view.bounds.size.width
        let imageHeight = self.view.bounds.size.height
        for (index, imageName) in guideImageName.enumerate() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = CGRect(x: CGFloat(index) * imageWidth, y: 0, width: imageWidth, height: imageHeight)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            container.addSubview(imageView)
        }
        container.contentSize = CGSize(width: imageWidth * CGFloat(guideImageName.count), height: imageHeight)
        
        //添加分页指示器
        pageControl = UIPageControl(frame: CGRectMake(0, 0, 100, 20))
        pageControl.center = CGPoint(x: imageWidth * 0.5, y: imageHeight - 80)
        pageControl.numberOfPages = guideImageName.count
        pageControl.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "pc_dot")!)
        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "pc_dot_hl")!)
        self.view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : scrollview delegate

    // 下面两个代理任用一个。下面这个代理需要一个锁，其实并不存在并发，不用锁也可以，直接用一个bool值防止enterApp多次调用
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if scrollView.contentOffset.x + scrollView.bounds.size.width > scrollView.contentSize.width + 50{
//            if onceLock.tryLock() {
//                if hasOnce {
//                    return
//                }
//                hasOnce = true
//                self.enterApp()
//                onceLock.unlock()
//            }
//        }
//    }

    // 进入app
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.x + scrollView.bounds.size.width + 50 > scrollView.contentSize.width {
            enterApp()
        }
    }
    
    // 修改分页指示器当前页码
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        pageControl.currentPage = page
    }
    
    func enterApp() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "notFirstTimeEnterApp")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("tabbarController")
    }

}
