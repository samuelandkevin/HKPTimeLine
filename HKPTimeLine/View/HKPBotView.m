//
//  HKPBotView.m
//  HKPTimeLine  仿赤兔、微博动态
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by samuelandkevin on 16/9/20.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import "HKPBotView.h"
#import "YHWorkGroupButton.h"

@interface HKPBotView()
@property (nonatomic,strong) UIView *viewTopLine;//顶部横线
@property (nonatomic,strong) UIView *viewVLine1;//竖线1
@property (nonatomic,strong) UIView *viewVLine2;//竖线2

@end

@implementation HKPBotView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView *viewTopLine = [UIView new];
    viewTopLine.backgroundColor = RGBCOLOR(222, 222, 222);
    [self addSubview:viewTopLine];
    self.viewTopLine = viewTopLine;
    
    //评论
    YHWorkGroupButton *btnComment = [YHWorkGroupButton new];
    [btnComment setTitle:@"0" forState:UIControlStateNormal];
    [btnComment setImage:[UIImage imageNamed:@"workgroup_img_comment"] forState:UIControlStateNormal];
    [btnComment addTarget:self action:@selector(onComment:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnComment];
    self.btnComment = btnComment;
    
    UIView *viewVLine1 = [UIView new];
    [self addSubview:viewVLine1];
    viewVLine1.backgroundColor = RGBCOLOR(222, 222, 222);
    self.viewVLine1 = viewVLine1;
    
    //点赞
    YHWorkGroupButton *btnLike = [YHWorkGroupButton new];
    [self addSubview:btnLike];
    [btnLike setTitle:@"0" forState:UIControlStateNormal];
    [btnLike setImage:[UIImage imageNamed:@"workgroup_img_like"] forState:UIControlStateNormal];
    [btnLike setImage:[UIImage imageNamed:@"workgroup_img_like_sel"] forState:UIControlStateSelected];
    [btnLike addTarget:self action:@selector(onLike:) forControlEvents:UIControlEventTouchUpInside];
    self.btnLike = btnLike;
    
    
    UIView *viewVLine2 = [UIView new];
    [self addSubview:viewVLine2];
    viewVLine2.backgroundColor = RGBCOLOR(222, 222, 222);
    self.viewVLine2 = viewVLine2;
    
    //分享
    YHWorkGroupButton *btnShare = [YHWorkGroupButton new];
    [btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [btnShare setImage:[UIImage imageNamed:@"workgroup_img_share"] forState:UIControlStateNormal];
    [btnShare addTarget:self action:@selector(onShare:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnShare];
    self.btnShare = btnShare;
    
    
    [self layoutUI];
    
}

- (void)layoutUI{
    __weak typeof(self) weakSelf = self;

    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf.viewTopLine.mas_bottom);
        make.width.equalTo(weakSelf.mas_width).dividedBy(3);
        make.bottom.equalTo(weakSelf).offset(-0.5);
    }];
    
    [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btnComment.mas_right);
        make.centerY.equalTo(weakSelf.btnComment.mas_centerY);
        make.width.mas_equalTo(weakSelf.btnComment.mas_width);
        make.height.mas_equalTo(weakSelf.btnComment.mas_height);
    }];
    
    [self.btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btnLike.mas_right);
        make.centerY.equalTo(weakSelf.btnComment.mas_centerY);
        make.width.mas_equalTo(weakSelf.btnComment.mas_width);
        make.height.mas_equalTo(weakSelf.btnComment.mas_height);
    }];
    
    [self.viewTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    [self.viewVLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(0.5);
         make.centerY.equalTo(weakSelf.btnComment.mas_centerY);
        make.right.equalTo(weakSelf.btnComment.mas_right);
        make.top.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
    }];
    
    [self.viewVLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(0.5);
         make.centerY.equalTo(weakSelf.btnComment.mas_centerY);
         make.right.equalTo(weakSelf.btnLike.mas_right);
         make.top.equalTo(weakSelf.viewVLine1.mas_top);
         make.bottom.equalTo(weakSelf.viewVLine1.mas_bottom);
    }];

}


#pragma mark - Action

- (void)onShare:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(onShare)]) {
        [_delegate onShare];
    }
    
}

- (void)onLike:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(onLike)]) {
        [_delegate onLike];
    }
}

- (void)onComment:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(onComment)]) {
        [_delegate onComment];
    }
}


@end
