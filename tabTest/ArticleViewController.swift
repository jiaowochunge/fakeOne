//
//  ArticleViewController.swift
//  tabTest
//
//  Created by 王益 on 15/5/4.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet var textView : UITextView!
    @IBOutlet var rateView : RatingView!
    @IBOutlet var rateScore : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.hidden = true
        
        var tmpTextView = UITextView()
        tmpTextView.frame = CGRectMake(0, 80, self.view.frame.size.width, 200)
        tmpTextView.font = UIFont.systemFontOfSize(16)
        tmpTextView.backgroundColor = UIColor.redColor()
        tmpTextView.text = "Configuration. Configure text views in Interface Builder, in the Text View section of the Attributes Inspector. A few configurations cannot be made through the Attributes Inspector, so you must make them programmatically. You can set other configurations programmatically, too, if you prefer. "
        self.view.addSubview(tmpTextView)
        
        rateView.decimalOnly = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ratingViewValueChanged(ratingView : RatingView) {
        rateScore.text = "\(rateView.rateScore)"
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
