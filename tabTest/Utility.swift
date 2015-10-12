//
//  Utility.swift
//  tabTest
//
//  Created by john on 15/6/16.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    /** 获取今日格式化日期 2015-06-16
    */
    class func dateStr() -> String {
        return Utility.dateStrBackStep(0)
    }
    
    /** 获取step日前格式化日期 2015-06-16
    */
    class func dateStrBackStep(step : Int) -> String {
        let date = NSDate().dateByAddingTimeInterval(Double(step * -86400))
        let calendar = NSCalendar.currentCalendar()
        let component = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: date)
        return String(format: "%d-%02d-%02d", component.year, component.month, component.day)
    }
    
}
