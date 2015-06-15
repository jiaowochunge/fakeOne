//
//  TestImageView.swift
//  tabTest
//
//  Created by 王益 on 15/5/21.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

class TestImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "first")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
