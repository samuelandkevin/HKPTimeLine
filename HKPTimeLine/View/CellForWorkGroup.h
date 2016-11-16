//
//  CellForQAList.h
//  github:  https://github.com/samuelandkevin
//
//  Created by samuelandkevin on 16/8/29.
//  Copyright © 2016年 HKP. All rights reserved.
//  原创视图

#import <UIKit/UIKit.h>
#import "YHWorkGroup.h"
#import "HKPBotView.h"

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
@property (nonatomic,strong)HKPBotView  *viewBottom;
@end
