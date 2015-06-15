//
//  GoodEntity.m
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "GoodEntity.h"

@implementation GoodEntity

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *)strDate {
    NSArray *tmpArr = [_strTm componentsSeparatedByString:@"-"];
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

@end
