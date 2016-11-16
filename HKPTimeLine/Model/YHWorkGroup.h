//
//  YHWorkGroup.h
//  github:  https://github.com/samuelandkevin
//
//  Created by samuelandkevin on 16/5/5.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHUserInfo.h"

//动态类型
typedef NS_ENUM(int,DynType){
    DynType_Original = 0, //原创
    DynType_Forward       //转发
};

//可见性
typedef NS_ENUM(int,VisibleType){
    Visible_AllPeople = 0,//所有人可见
    Visible_OnlyFriend    //仅好友可见
};


@interface YHWorkGroup : NSObject

@property (nonatomic, copy)   NSString  *dynamicId; //动态Id
@property (nonatomic, strong) YHUserInfo *userInfo; //发布动态用户
@property (nonatomic, assign) DynType type;         //动态类型
@property (nonatomic, copy)   NSString *publishTime;//发布时间
@property (nonatomic, copy)   NSString *msgContent; //动态文本内容
@property (nonatomic, assign) int commentCount;     //评论数
@property (nonatomic, assign) int likeCount;        //点赞数
@property (nonatomic, assign) BOOL isLike;          //是否喜欢
@property (nonatomic, assign) VisibleType visible;  //可见性
@property (nonatomic, strong) NSArray <NSURL *>*originalPicUrls; //原图像Url
@property (nonatomic, strong) NSArray <NSURL *>*thumbnailPicUrls;//缩略图Url
@property (nonatomic, strong) YHWorkGroup *forwardModel;//上一条动态

@property (nonatomic, assign) BOOL isRepost;//转发
@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;
@property (nonatomic, assign) BOOL showDeleteButton;
@property (nonatomic, assign) BOOL hiddenBotLine;//隐藏底部高度15的分隔线

@end

