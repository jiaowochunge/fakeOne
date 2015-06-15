//
//  ArticleEntity.m
//  tabTest
//
//  Created by john on 15/6/15.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "ArticleEntity.h"

@implementation ArticleEntity

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *)strDate
{
    NSArray *tmpArr = [_strContMarketTime componentsSeparatedByString:@"-"];
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

- (NSString *)processedContent
{
    NSString *proc = [_strContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    NSArray *line = [proc componentsSeparatedByString:@"\n"];
    
    NSMutableString *output = [[NSMutableString alloc] init];
    for (int i = 0; i < 200 && i < line.count; ++i) {
        [output appendFormat:@"%@\n", line[i]];
    }
    return output;
}

- (NSArray *)lineArr
{
    return [_strContent componentsSeparatedByString:@"<br>"];
}

@end
