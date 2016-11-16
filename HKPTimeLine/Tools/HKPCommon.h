//
//  HKPCommon.h
//  HKPTimeLine  仿赤兔、微博动态
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by samuelandkevin on 16/9/20.
//  Copyright © 2016年 HKP. All rights reserved.
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
