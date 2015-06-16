//
//  Utility.swift
//  tabTest
//
//  Created by john on 15/6/16.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    class func dateStr() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let component = calendar.components(NSCalendarUnit.CalendarUnitDay | .CalendarUnitYear | .CalendarUnitMonth, fromDate: date)
        return String(format: "%d-%02d-%02d", component.year, component.month, component.day)
    }
    
}
