//
//  HomepageEntity.m
//  tabTest
//
//  Created by john on 15/6/9.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "HomepageEntity.h"

@implementation HomepageEntity

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(BOOL)propertyIsIgnored:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"strWorkName"] || [propertyName isEqualToString:@"strWorkAuthor"]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)strWorkName
{
    NSArray *tmpArr = [_strAuthor componentsSeparatedByString:@"&"];
    return tmpArr.firstObject;
}

- (NSString *)strWorkAuthor
{
    NSArray *tmpArr = [_strAuthor componentsSeparatedByString:@"&"];
    return tmpArr.lastObject;
}

- (NSString *)strDay
{
    @try {
        return [_strMarketTime substringFromIndex:8];
    }
    @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)strMonthYear
{
    NSArray *tmpArr = [_strMarketTime componentsSeparatedByString:@"-"];
    @try {
        NSString *year = [tmpArr objectAtIndex:0];
        NSInteger month = ((NSString *)[tmpArr objectAtIndex:1]).integerValue;
        
        NSString *output = @"";
        switch (month) {
            case 1:
                output = [@"January," stringByAppendingString:year];
                break;
            case 2:
                output = [@"February," stringByAppendingString:year];
                break;
            case 3:
                output = [@"March," stringByAppendingString:year];
                break;
            case 4:
                output = [@"April," stringByAppendingString:year];
                break;
            case 5:
                output = [@"May," stringByAppendingString:year];
                break;
            case 6:
                output = [@"June," stringByAppendingString:year];
                break;
            case 7:
                output = [@"July," stringByAppendingString:year];
                break;
            case 8:
                output = [@"August," stringByAppendingString:year];
                break;
            case 9:
                output = [@"September," stringByAppendingString:year];
                break;
            case 10:
                output = [@"October," stringByAppendingString:year];
                break;
            case 11:
                output = [@"November," stringByAppendingString:year];
                break;
            case 12:
                output = [@"December," stringByAppendingString:year];
                break;
            default:
                break;
        }
        return output;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

@end
