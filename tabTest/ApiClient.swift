//
//  ApiClient.swift
//  tabTest
//
//  Created by john on 15/6/9.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class ApiClient: NSObject {
    
    class func GET(urlStr : String, parameters : AnyObject, success : ((operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void)!, failure : ((operation: AFHTTPRequestOperation!, error: NSError!) -> Void)!) -> AFHTTPRequestOperation {
        var manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.timeoutInterval = 30
        manager.responseSerializer.acceptableContentTypes = ["text/html", "text/plain"]
        return manager.GET(urlStr, parameters: parameters, success: success, failure: failure)
    }
    
}
