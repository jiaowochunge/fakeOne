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
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "text/plain"])
        return manager.GET(urlStr, parameters: parameters, success: success, failure: failure)
    }
    
//        AFHTTPRequestOperationManager().GET("http://bea.wufazhuce.com/OneForWeb/one/getHp_N", parameters: param, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
//    var retDic = responseObject as [String : AnyObject]
//    if retDic["result"] != nil && retDic["result"]!.isEqual("SUCCESS") {
//    var homeData = HomepageEntity(dictionary: retDic["hpEntity"] as Dictionary, error: nil)
//    self.collectionData.append(homeData)
//    self.collectionView!.reloadData()
//    NSLog("自我感觉良好")
//    } else {
//    NSLog("返回数据错误")
//    }
//    }) { (operation: AFHTTPRequestOperation!, error:NSError!) -> Void in
//    NSLog("请求返回错误:%@", error)
//    }
}
