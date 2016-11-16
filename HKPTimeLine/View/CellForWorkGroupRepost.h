//
//  CellForWorkGroupRepost.h
//  HKPTimeLine  仿赤兔、微博动态
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by samuelandkevin on 16/9/20.
//  Copyright © 2016年 HKP. All rights reserved.
//  转发视图

#import <UIKit/UIKit.h>
#import "YHWorkGroup.h"
#import "HKPBotView.h"

@class CellForWorkGroupRepost;
@protocol CellForWorkGroupRepostDelegate <NSObject>

- (void)onAvatarInRepostCell:(CellForWorkGroupRepost *)cell;
- (void)onTapRepostViewInCell:(CellForWorkGroupRepost *)cell;
- (void)onCommentInRepostCell:(CellForWorkGroupRepost *)cell;
- (void)onLikeInRepostCell:(CellForWorkGroupRepost *)cell;
- (void)onShareInRepostCell:(CellForWorkGroupRepost *)cell;
- (void)onDeleteInRepostCell:(CellForWorkGroupRepost *)cell;
- (void)onMoreInRespostCell:(CellForWorkGroupRepost *)cell;
@end

@interface CellForWorkGroupRepost : UITableViewCell

@property (nonatomic) NSIndexPath *indexPath;
@property (weak,nonatomic) id<CellForWorkGroupRepostDelegate>delegate;
@property (nonatomic,strong) YHWorkGroup *model;
@property (nonatomic,strong) HKPBotView  *viewBottom;
@end
