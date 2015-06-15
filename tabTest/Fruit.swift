//
//  Fruit.swift
//  tabTest
//
//  Created by john on 15/6/8.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class Fruit: NSObject {
    override var description: String {
        var output = ""
        output += "I am a fruit"
        return output
    }
//    override class func description() -> String {
//        return "I am a fruit"
//    }
}

class Apple : Fruit {
    override class func description() -> String {
        return "I am a apple"
    }
}

class PineApple: Fruit {
    override class func description() -> String {
        return "I am a pineapple"
    }
}
