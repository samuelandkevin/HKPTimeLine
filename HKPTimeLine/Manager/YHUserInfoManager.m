//
//  YHUserInfoManager.m
//  github:  https://github.com/samuelandkevin
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by kun on 16/4/25.
//  Copyright © 2016年 HKP. All rights reserved.
//  用户信息管理

#import "YHUserInfoManager.h"

@interface YHUserInfoManager ()

@end

@implementation YHUserInfoManager

- (instancetype)init
{
	self = [super init];

	if (!self)
	{
		return nil;
	}

	return self;
}

+ (instancetype)sharedInstance
{
	static YHUserInfoManager *g_ins = nil;
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		g_ins = [YHUserInfoManager new];
	});
	return g_ins;
}

#pragma mark - Getter
- (YHUserInfo *)userInfo
{
	if (!_userInfo)
	{
		_userInfo = [YHUserInfo new];
	}
	_userInfo.isSelfModel = YES;
	return _userInfo;
}


@end
