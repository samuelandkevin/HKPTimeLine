//
//  HKPBotView.h
//  HKPTimeLine  仿赤兔、微博动态
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by samuelandkevin on 16/9/20.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHWorkGroupButton.h"
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
