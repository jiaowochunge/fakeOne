//
//  ArticleEntity.h
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "JSONModel.h"

@interface ArticleEntity : JSONModel

//http://bea.wufazhuce.com/OneForWeb/one/getC_N?strDate=2015-06-09&strRow=1

/**
 "2015-06-14 23:14:26"
 */
@property (nonatomic, strong) NSString *strLastUpdateDate;
/**
 ""
 */
@property (nonatomic, strong) NSString *strContent;
/**
 "http:\/\/wufazhuce.com\/one\/vol.981#articulo"
 */
@property (nonatomic, strong) NSString *sWebLk;
/**
 "http:\/\/211.152.49.184:9000\/upload\/onephoto\/f1433388882573.jpg"
 */
@property (nonatomic, strong) NSString *wImgUrl;
/**
 "65338"
 */
@property (nonatomic, strong) NSString *sRdNum;
/**
 "1254"
 */
@property (nonatomic, strong) NSString *strPraiseNumber;
/**
 ""
 */
@property (nonatomic, strong) NSString *strContDayDiffer;
/**
 "1059"
 */
@property (nonatomic, strong) NSString *strContentId;
/**
 "藕荷色劫案"
 */
@property (nonatomic, strong) NSString *strContTitle;
/**
 "郑在欢"
 */
@property (nonatomic, strong) NSString *strContAuthor;
/**
 "（责任编辑：卫天成）"
 */
@property (nonatomic, strong) NSString *strContAuthorIntroduce;
/**
 "2015-06-15"
 */
@property (nonatomic, strong) NSString *strContMarketTime;
/**
 "不按照计划，就不会知道发生什么。"
 */
@property (nonatomic, strong) NSString *sGW;
/**
 "郑在欢，青年作者。"
 */
@property (nonatomic, strong) NSString *sAuth;
/**
 "@郑在欢"
 */
@property (nonatomic, strong) NSString *sWbN;
/**
 ""
 */
@property (nonatomic, strong) NSString *subTitle;

/** 格式化日期
 */
@property (nonatomic, readonly) NSString *strDate;

@property (nonatomic, readonly) NSString *processedContent;

@property (nonatomic, readonly) NSArray *lineArr;

@end
