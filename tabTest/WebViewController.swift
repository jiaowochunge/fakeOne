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
    
    private var webView : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        webView = UIWebView(frame: self.view.bounds)
        webView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        webView.delegate = self
        self.view.addSubview(webView)

        if urlString == nil {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            webView.loadHTMLString(urlString!, baseURL: nil)
            if let url = NSURL(string: urlString!) {
                webView.loadRequest(NSURLRequest(URL: url))
            }
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
