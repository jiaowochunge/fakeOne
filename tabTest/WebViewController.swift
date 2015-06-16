//
//  WebViewController.swift
//  tabTest
//
//  Created by john on 15/6/16.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var urlString : String?
    
    @IBOutlet var webView : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if urlString == nil {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            webView.loadHTMLString(urlString!, baseURL: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.title = webView.stringByEvaluatingJavaScriptFromString("document.title")
    }

}
