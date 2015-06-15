//
//  HomepageEntity.h
//  tabTest
//
//  Created by john on 15/6/9.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "JSONModel.h"

@interface HomepageEntity : JSONModel

/**
 "2015-06-02 17:04:58"
 */
@property (nonatomic, strong) NSString *strLastUpdateDate;
/**
 ""
 */
@property (nonatomic, strong) NSString *strDayDiffer;
/**
 "988"
 */
@property (nonatomic, strong) NSString *strHpId;
/**
 "VOL.975"
 */
@property (nonatomic, strong) NSString *strHpTitle;
/**
 "http:\/\/pic.yupoo.com\/hanapp\/EGwgfKnq\/sNkJl.jpg"
 */
@property (nonatomic, strong) NSString *strThumbnailUrl;
/**
 "http:\/\/pic.yupoo.com\/hanapp\/EGwgfKnq\/sNkJl.jpg"
 */
@property (nonatomic, strong) NSString *strOriginalImgUrl;
/**
 "波点海洋——我走先&莫頔 作品"
 */
@property (nonatomic, strong) NSString *strAuthor;
/**
 "你是你自己的裁决者。你过去和现在做得有多好，由你自己说了算。别人永远不能审判你，就算是神。 from 《与神对话》"
 */
@property (nonatomic, strong) NSString *strContent;
/**
 "2015-06-09"
 */
@property (nonatomic, strong) NSString *strMarketTime;
/**
 "http:\/\/wufazhuce.com\/one\/vol.975"
 */
@property (nonatomic, strong) NSString *sWebLk;
/**
 "9513"
 */
@property (nonatomic, strong) NSString *strPn;
/**
 "http:\/\/211.152.49.184:9000\/upload\/onephoto\/f1432797418398.jpg"
 */
@property (nonatomic, strong) NSString *wImgUrl;

@property (nonatomic, readonly) NSString *strWorkName;

@property (nonatomic, readonly) NSString *strWorkAuthor;

@property (nonatomic, readonly) NSString *strDay;

@property (nonatomic, readonly) NSString *strMonthYear;

@end
