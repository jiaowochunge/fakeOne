//
//  FONavigationController.swift
//  tabTest
//
//  Created by john on 15/11/24.
//  Copyright © 2015年 test. All rights reserved.
//

import UIKit

class FONavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        // 不写下面这句话，导致系统自带返回手势无效。不知道为什么
        self.interactivePopGestureRecognizer?.delegate = self
        self.customNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func customNavigationBar() {
        // 影响左键右键等颜色
        self.navigationBar.tintColor = UIColor.whiteColor()
        // bar 的背景色
        self.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "navigationBarBG")!)
        self.navigationBar.shadowImage = UIViewController.clearImage()
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(20), NSForegroundColorAttributeName: UIColor(red: 62 / 255.0, green: 189 / 255.0, blue: 235 / 255.0, alpha: 1)]
        
        // 返回键样式。返回键的标题，在 customNavigationBackButton 中设置。
        let backImage: UIImage = UIImage(named: "backButton_hl")!
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
    }

}

extension FONavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Push {
            fromVC.hidesBottomBarWhenPushed = true
            fromVC.customNavigationBackButton()
        } else if operation == .Pop {
            if navigationController.viewControllers.count == 1 {
                toVC.hidesBottomBarWhenPushed = false
            }
        }
        return nil
    }
}
