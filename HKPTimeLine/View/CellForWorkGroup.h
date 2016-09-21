//
//  CellForQAList.h
//  PikeWay
//
//  Created by YHIOS002 on 16/8/29.
//  Copyright © 2016年 YHSoft. All rights reserved.
//  原创视图

#import <UIKit/UIKit.h>
#import "YHWorkGroup.h"


@class CellForWorkGroup;
@protocol CellForWorkGroupDelegate <NSObject>

- (void)onAvatarInCell:(CellForWorkGroup *)cell;
- (void)onMoreInCell:(CellForWorkGroup *)cell;
- (void)onCommentInCell:(CellForWorkGroup *)cell;
- (void)onLikeInCell:(CellForWorkGroup *)cell;
- (void)onShareInCell:(CellForWorkGroup *)cell;

@optional
- (void)onDeleteInCell:(CellForWorkGroup *)cell;

@end

@interface CellForWorkGroup : UITableViewCell

@property (nonatomic,strong) YHWorkGroup *model;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic, weak) id<CellForWorkGroupDelegate> delegate;
@end
