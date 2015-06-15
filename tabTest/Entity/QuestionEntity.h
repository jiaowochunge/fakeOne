//
//  QuestionEntity.h
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "JSONModel.h"

@class EntQNCmt;

//http://bea.wufazhuce.com/OneForWeb/one/getQ_N?strUi=&strDate=2015-06-09&strRow=1

@interface QuestionEntity : JSONModel

@property (nonatomic, strong) EntQNCmt *entQNCmt;

/**
 2015-06-15 17:03:54
 */
@property (nonatomic, strong) NSString *strLastUpdateDate;

/**
 
 */
@property (nonatomic, strong) NSString *strDayDiffer;

/**
 "http:\/\/wufazhuce.com\/one\/vol.981#cuestion"
 */
@property (nonatomic, strong) NSString *sWebLk;

/**
 "5335"
 */
@property (nonatomic, strong) NSString *strPraiseNumber;

/**
 "1009"
 */
@property (nonatomic, strong) NSString *strQuestionId;

/**
 */
@property (nonatomic, strong) NSString *strQuestionTitle;

/**
 */
@property (nonatomic, strong) NSString *strQuestionContent;

/**
 */
@property (nonatomic, strong) NSString *strAnswerTitle;

/**
 */
@property (nonatomic, strong) NSString *strAnswerContent;

/**
 "2015-06-15"
 */
@property (nonatomic, strong) NSString *strQuestionMarketTime;

/**
 */
@property (nonatomic, strong) NSString *sEditor;

@end

@interface EntQNCmt : JSONModel

@property (nonatomic, strong) NSString *strCnt;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *strD;

@property (nonatomic, strong) NSString *pNum;

@property (nonatomic, strong) NSString *upFg;

@end
