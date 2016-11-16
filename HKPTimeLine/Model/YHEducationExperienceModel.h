//
//  YHEducationExperienceModel.h
//  github:  https://github.com/samuelandkevin
//
//  Created by samuelandkevin on 16/5/17.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHEducationExperienceModel : NSObject

@property(nonatomic,copy)   NSString * eduExpId;
@property(nonatomic,strong) NSString * school;
@property(nonatomic,strong) NSString * major;
@property(nonatomic,strong) NSString * educationBackground;
@property(nonatomic,strong) NSString * beginTime;
@property(nonatomic,strong) NSString * endTime;
@property(nonatomic,strong) NSString * moreDescription;

@end
