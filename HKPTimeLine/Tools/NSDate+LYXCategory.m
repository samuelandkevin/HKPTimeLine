//
//  NSDate+LYXCategory.m
//  OA
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by liuyx on 15/7/23.
//  Copyright (c) 2015年 com.tgnet. All rights reserved.
//

#import "NSDate+LYXCategory.h"

@implementation NSDate (LYXCategory)

/**
 *  格式化日期
 *
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 字符串
 */
- (NSString *)toStringByformat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *returnString = [formatter stringFromDate:self];
//    ARC_RELEASE(dateFormatter);
    return returnString;
}

//获取固定的时间格式的当前时间 @"yyyy-MM-dd'T'HH:mm:ss"
- (NSString *)getNowDate{
    NSString *dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *returnString = [formatter stringFromDate:self];
//    ARC_RELEASE(dateFormatter);
    return returnString;
}

//根据字符串格式转换字符串为日期
+(NSDate *)dateByStringFormat:(NSString *)format dateString:(NSString *)dateString{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

+(NSDate *)dateByYear:(NSInteger)year month:(NSInteger)month date:(NSInteger)date hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateObj=[formatter dateFromString:[NSString stringWithFormat:@"%4d-%2d-%2d %2d:%2d:%2d",year,month,date,hour,minute,second]];
    return dateObj;
}

+(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <=3){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        result = [compareDate toStringByformat:@"yyyy-MM-dd"];
    }
    
    return  result;
}

//获取NSDate的年份部分
+(NSInteger)getFullYear:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearStr=[formatter stringFromDate:date];
    return atoi([yearStr UTF8String]);
}

//获取NSDate的月份部分
+(NSInteger)getMonth:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *monthStr=[formatter stringFromDate:date];
    return atoi([monthStr UTF8String]);
}
//获取NSDate的日期部分
+(NSInteger)getDate:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *dateStr=[formatter stringFromDate:date];
    return atoi([dateStr UTF8String]);
}
//获取NSDate的小时部分
+(NSInteger)getHour:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *hourStr=[formatter stringFromDate:date];
    return atoi([hourStr UTF8String]);
}
//获取NSDate的分钟部分
+(NSInteger)getMinute:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter dateFromString:@"mm"];
    NSString *minuteStr=[formatter stringFromDate:date];
    return atoi([minuteStr UTF8String]);
}
//获取NSDate的秒部分
+(NSInteger)getSecond:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter dateFromString:@"ss"];
    NSString *secondStr=[formatter stringFromDate:date];
    return atoi([secondStr UTF8String]);
}

@end
