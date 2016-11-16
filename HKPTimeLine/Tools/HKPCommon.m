//
//  HKPCommon.m
//  HKPTimeLine  仿赤兔、微博动态
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by samuelandkevin on 16/9/20.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import "HKPCommon.h"
#import "NSDate+LYXCategory.h"


@implementation HKPCommon


@end


NSString *showDateString(NSString *dateString){
    if (!dateString) {
        return @"";
    }
    NSDate *date = dateFromString(dateString);
    return getNormalShowDateString(date);
}

/**
 *  格式化日期
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 
 */
NSString *toStringByformat(NSString *dateFormat,NSDate *date)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *returnString = [formatter stringFromDate:date];
    return returnString;
}

NSDate *dateFromString(NSString *dateString){
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

NSString *getNormalShowDateString(NSDate *date)
{
    NSDate *nowDate      =  [NSDate date];
    NSString *dateStr    =  toStringByformat(@"yyyy-MM-dd", date);
    NSString *curDateStr =  toStringByformat(@"yyyy-MM-dd", nowDate);
    
    if ([dateStr isEqualToString:curDateStr])
    {
        //当天信息
        NSInteger hour =  [toStringByformat(@"HH", date) integerValue];
        NSString *strMonment = @"";
        if(hour < 6){
            strMonment = @"凌晨";
        }
        else if (hour < 12){
            strMonment = @"上午";
        }
        else if (hour < 18){
            strMonment = @"下午";
        }
        else{
            strMonment = @"晚上";
        }
        return toStringByformat([NSString stringWithFormat:@"%@ HH:mm",strMonment],date);
    }
    else
    {
        NSDate *yesterday = [NSDate dateWithTimeIntervalSince1970:[nowDate timeIntervalSince1970]-(24*60*60)];
        NSDate *dayBeforeYesterday = [NSDate dateWithTimeIntervalSince1970:[nowDate timeIntervalSince1970] - 48*60*60];
        
        NSString *yesterdatStr =  [yesterday toStringByformat:@"yyyy-MM-dd"];
        NSString *dayBeYesdatStr  =  [dayBeforeYesterday toStringByformat:@"yyyy-MM-dd"];
        if ([dateStr isEqualToString:yesterdatStr])//昨天
        {
            return toStringByformat(@"昨天 HH:mm",date);
        }
        else if ([dateStr isEqualToString:dayBeYesdatStr])
        {
            return toStringByformat(@"前天 HH:mm", date);
        }
        else
        {
            NSString *dateStr = [date toStringByformat:@"yyyy" ];
            NSString *curDateStr = [nowDate toStringByformat:@"yyyy"];
            if ([dateStr isEqualToString:curDateStr])//当年
            {
                NSString *toString = toStringByformat(@"M月d日",date);
                return toString;
                
            }
            else//超过一年
            {
                return toStringByformat(@"yyyy年MM月dd日",date);
            }
        }
    }
}
