//
//  waterfallLayout.swift
//  tabTest
//
//  Created by john on 15/6/5.
//  Copyright (c) 2015年 test. All rights reserved.
//

import UIKit

protocol UICollectionViewDelegateWaterfallLayout : UICollectionViewDelegate {
    
    
    //瀑布流指定单元格大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> Bool
    
    //瀑布流头大小
    func collectionView(collecitonView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: NSInteger) -> CGSize
}

class waterfallLayout: UICollectionViewLayout {
   
}
