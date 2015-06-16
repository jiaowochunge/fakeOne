//
//  QuestionEntity.m
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "QuestionEntity.h"

@implementation QuestionEntity

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *)strDate {
    NSArray *tmpArr = [_strQuestionMarketTime componentsSeparatedByString:@"-"];
    @try {
        NSString *year = [tmpArr objectAtIndex:0];
        NSInteger month = ((NSString *)[tmpArr objectAtIndex:1]).integerValue;
        NSString *day = [tmpArr objectAtIndex:2];
        
        NSArray *monthArr = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
        NSString *output = [NSString stringWithFormat:@"%@ %@,%@", monthArr[month - 1], day, year];
        
        return output;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

- (NSArray *)lineArr
{
    //去掉<i>标记后的内容
    NSRange range = [_strAnswerContent rangeOfString:@"<i>"];
    if (range.location != NSNotFound) {
        NSString *subStr = [_strAnswerContent substringToIndex:range.location];
        return [subStr componentsSeparatedByString:@"<br>"];
    } else {
        return [_strAnswerContent componentsSeparatedByString:@"<br>"];
    }
}

@end
