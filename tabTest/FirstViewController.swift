//
//  FirstViewController.swift
//  tabTest
//
//  Created by john on 15/4/9.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var label3 : UILabel?
    
    let count : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let title = "First Tab";
        let age : Int = 27;
        
        var optionalString: String? = "Hello"
        optionalString = nil
        
        var optionalName: String?
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        
        for i in 0...3 {
            println(i);
        }
        
        let print8 = {
            (a:Int) in
            println("8")
        }
        
        print8(3)
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 85, 510]
        let strings = numbers.map {
            (var number) -> String in
            var output = ""
            while number > 0 {
                output = digitNames[number % 10]! + output
                number /= 10
            }
            return output
        }
        
        var name1 = String()
        
        println(strings);
        
        let incrementTen = makeIncrementor(forIncrementor: 10);
        println(incrementTen());
        println(incrementTen());
        println(incrementTen());

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeIncrementor(forIncrementor amount : Int) -> () -> Int {
        var runningTotal = 0;
        func incrementor() -> Int {
            runningTotal += amount;
            return runningTotal;
        }
        return incrementor;
    }


}

