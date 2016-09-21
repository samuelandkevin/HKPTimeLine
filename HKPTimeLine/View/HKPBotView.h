//
//  HKPBotView.h
//  HKPTimeLine
//
//  Created by YHIOS002 on 16/9/20.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHWorkGroupButton;
@class HKPBotView;

@protocol HKPBotViewDelegate <NSObject>

- (void)onComment;
- (void)onLike;
- (void)onShare;

@end

@interface HKPBotView : UIView

@property (nonatomic,strong)YHWorkGroupButton *btnComment;
@property (nonatomic,strong)YHWorkGroupButton *btnLike;
@property (nonatomic,strong)YHWorkGroupButton *btnShare;
@property (nonatomic,weak)id<HKPBotViewDelegate>delegate;
@end
