//
//  GoodEntity.h
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "JSONModel.h"

//http://bea.wufazhuce.com/OneForWeb/one/o_f?strDate=2015-06-15&strRow=1
@interface GoodEntity : JSONModel

/**
 * "2015-06-05 17:08:50"
 */
@property (nonatomic, strong) NSString *strLastUpdateDate;

/**
 * "0"
 */
@property (nonatomic, strong) NSString *strPn;

/**
 * "http:\/\/pic.yupoo.com\/hanapp\/EHAgoM75\/V11X0.jpg"
 */
@property (nonatomic, strong) NSString *strBu;

/**
 * "2015-06-15"
 */
@property (nonatomic, strong) NSString *strTm;

/**
 * "http:\/\/wufazhuce.com\/one\/vol.981#cosas"
 */
@property (nonatomic, strong) NSString *strWu;

/**
 * "515"
 */
@property (nonatomic, strong) NSString *strId;

/**
 * "墙角灯"
 */
@property (nonatomic, strong) NSString *strTt;

/**
 * "墙角的挖开并不一定会揭开一些让人避而远之的阴暗面，恰恰相反，里面也可能是光明的wonderland."
 */
@property (nonatomic, strong) NSString *strTc;

//格式化日期
@property (nonatomic, readonly) NSString *strDate;

@end
