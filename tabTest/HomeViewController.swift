//
//  HomeViewController.swift
//  tabTest
//
//  Created by john on 15/4/29.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var vol : UILabel!
    @IBOutlet var workImage : UIImageView!
    @IBOutlet var workName : UILabel!
    @IBOutlet var workAuthor : UILabel!
    @IBOutlet var workBrief : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIViewController.customTabbar()
        UIViewController.customNavigationBar()

        var titleView = UILabel()
        titleView.text = "ONE"
        titleView.font = UIFont.systemFontOfSize(20)
        titleView.sizeToFit()
        self.navigationItem.titleView = titleView
        
        
//        dispatch_async(dispatch_get_main_queue(), {
//            var url : NSURL? = NSURL(string: "http://www.impf2010.com/ea/android/sajax_ea_getProducts.jspa?pageNumber")
//            if ( url != nil) {
//                var responseData : NSData? = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: url!), returningResponse: nil, error: nil)
//                if responseData != nil {
//                    var jsonStr : NSString? = NSString(data: responseData!, encoding: NSUTF8StringEncoding)
//                    //                println(jsonStr)
//                }
//            }
//        })
        
        var now : NSDate = NSDate()
        var interval : Double = NSDate.timeIntervalSinceReferenceDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapWorkImage(gesture : UIGestureRecognizer) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
