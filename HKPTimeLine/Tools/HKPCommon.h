//
//  HKPCommon.h
//  HKPTimeLine
//
//  Created by YHIOS002 on 16/9/20.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HKPCommon : NSObject



@end

#ifdef __cplusplus

extern "C" {
#endif

    
        NSString *showDateString(NSString *dateString);
        NSDate   *dateFromString(NSString *dateString);
        NSString *getNormalShowDateString(NSDate *date);
    
        NSString *toStringByformat(NSString *dateFormat,NSDate *date);


    #ifdef __cplusplus
    };  // extern

#endif