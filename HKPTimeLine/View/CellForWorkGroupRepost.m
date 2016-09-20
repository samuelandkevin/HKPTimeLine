//
//  CellForWorkGroupRepost.m
//  HKPTimeLine
//
//  Created by YHIOS002 on 16/9/20.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "CellForWorkGroupRepost.h"
#import "HKPBotView.h"
#import "YHWorkGroupPhotoContainer.h"
#import "HKPCommon.h"

#pragma mark - YHWorkGroupRepostView
/***********上一条动态***********/
@interface YHWorkGroupRepostView : UIView

@property (nonatomic,strong)UIImageView *imgvAvatar;
@property (nonatomic,strong)UILabel  *labelName;
@property (nonatomic,strong)UILabel  *labelContent;
@property (nonatomic,strong)YHWorkGroupPhotoContainer *picContainerView;
@property (nonatomic,strong)UILabel  *labelPubTime;
@property (nonatomic,strong)UILabel  *labelCompany;
@property (nonatomic,strong)UILabel  *labelJob;
@property (nonatomic,strong)UILabel  *labelIndustry;

@property (nonatomic,assign)BOOL shouldOpenContentLabel;
@property (nonatomic,strong)YHWorkGroup *forwardModel;

@end

static const CGFloat contentLabelFontSizeRepost = 13;

@implementation YHWorkGroupRepostView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    _shouldOpenContentLabel = NO;
    
    //头像
    _imgvAvatar = [UIImageView new];
    [self addSubview:_imgvAvatar];
    
    _labelName = [UILabel new];
    _labelName.font = [UIFont systemFontOfSize:14];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.textColor = [UIColor blackColor];
    [self addSubview:_labelName];
    
    _labelIndustry   = [UILabel new];
    _labelIndustry.font = [UIFont systemFontOfSize:11];
    _labelIndustry.textAlignment = NSTextAlignmentLeft;
    _labelIndustry.textColor = RGBCOLOR(96, 96, 96);
    [self addSubview:_labelIndustry];
    
    _labelPubTime = [UILabel new];
    _labelPubTime.font = [UIFont systemFontOfSize:12];
    _labelPubTime.textAlignment = NSTextAlignmentRight;
    _labelPubTime.textColor = RGBCOLOR(96, 96, 96);
    [self addSubview:_labelPubTime];
    
    
    _labelCompany = [UILabel new];
    _labelCompany.font = [UIFont systemFontOfSize:12];
    _labelCompany.textColor = RGBCOLOR(96, 96, 96);
    [self addSubview:_labelCompany];
    
    
    _labelJob      = [UILabel new];
    _labelJob.font = [UIFont systemFontOfSize:12];
    _labelJob.textColor = RGBCOLOR(96, 96, 96);
    [self addSubview:_labelJob];
    
    _labelContent = [UILabel new];
    _labelContent.font = [UIFont systemFontOfSize:contentLabelFontSizeRepost];
    _labelContent.textColor = RGBCOLOR(96, 96, 96);
    _labelContent.numberOfLines = 2;
    [self addSubview:_labelContent];
    
    _picContainerView = [[YHWorkGroupPhotoContainer alloc] initWithWidth:SCREEN_WIDTH-40];
    [self addSubview:_picContainerView];
    
    [self layoutUI];
    
    self.backgroundColor = RGBCOLOR(244, 244, 244);
    //kun调试
//    self.labelJob.backgroundColor = [UIColor yellowColor];
//    self.labelContent.backgroundColor = [UIColor blackColor];
//    self.labelCompany.backgroundColor = [UIColor orangeColor];
//    self.labelPubTime.backgroundColor = [UIColor darkGrayColor];
//    self.labelName.backgroundColor = [UIColor greenColor];
//    self.labelIndustry.backgroundColor = [UIColor brownColor];
    
}

- (void)layoutUI{
    __weak typeof(self)weakSelf = self;
    [self.imgvAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(15);
        make.left.equalTo(weakSelf).offset(15);
        make.width.height.mas_equalTo(45);
    }];
    
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(15);
        make.left.equalTo(weakSelf.imgvAvatar.mas_right).offset(10);
        make.right.equalTo(weakSelf.labelIndustry.mas_left).offset(-10);
    }];

    
    [self.labelIndustry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.labelName.mas_bottom);
        make.left.equalTo(weakSelf.labelName.mas_right).offset(10);
        make.right.equalTo(weakSelf.labelPubTime.mas_left).offset(-10);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
    
    
    [self.labelIndustry setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelIndustry setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisHorizontal];

    [self.labelPubTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.labelName.mas_bottom);
        make.right.equalTo(weakSelf).offset(-15);
    }];
    [self.labelPubTime setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelPubTime setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [self.labelCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.labelName.mas_bottom).offset(9);
        make.left.equalTo(weakSelf.labelName.mas_left);
        make.right.equalTo(weakSelf.labelJob.mas_left).offset(-10);
    }];
    
    [self.labelJob mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.labelCompany.mas_bottom);
        make.left.equalTo(weakSelf.labelCompany.mas_right).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
        make.width.mas_greaterThanOrEqualTo(80);
    }];
    
    [self.labelJob setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelJob setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisHorizontal];

    
    [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgvAvatar.mas_bottom).offset(11);
        make.left.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
    }];
    
    [self.labelContent setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
    [self.labelContent setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
    
    // 不然在6/6plus上就不准确了
    self.labelContent.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    
    [self.picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf.labelContent.mas_bottom).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
        make.bottom.equalTo(weakSelf).offset(-10);
    }];
    
}

-(void)setForwardModel:(YHWorkGroup *)forwardModel{
    _forwardModel = forwardModel;
    _shouldOpenContentLabel = NO;
    
    [self.imgvAvatar sd_setImageWithURL:_forwardModel.userInfo.avatarUrl placeholderImage:[UIImage imageNamed:@"common_avatar_120px"]];
    if (_forwardModel.userInfo.userName.length) {
        _labelName.text   = _forwardModel.userInfo.userName;
    }
    else{
        _labelName.text    = @"匿名用户";
    }
    
    self.labelIndustry.text = _forwardModel.userInfo.industry;
    self.labelJob.text      = _forwardModel.userInfo.job;
    self.labelPubTime.text  =  _forwardModel.publishTime;
    
    self.labelContent.text  = _forwardModel.msgContent;
    
    self.labelCompany.text  = _forwardModel.userInfo.company;
    
    self.picContainerView.picOriArray = _forwardModel.originalPicUrls;
    self.picContainerView.picUrlArray = _forwardModel.thumbnailPicUrls;
    
}

@end


#pragma mark - CellForWorkGroupRepost
@interface CellForWorkGroupRepost()

@property (nonatomic,strong)UIImageView *imgvAvatar;
@property (nonatomic,strong)UILabel     *labelName;
@property (nonatomic,strong)UILabel     *labelIndustry;
@property (nonatomic,strong)UILabel     *labelPubTime;
@property (nonatomic,strong)UILabel     *labelCompany;
@property (nonatomic,strong)UILabel     *labelJob;
@property (nonatomic,strong)UILabel     *labelContent;
@property (nonatomic,strong)UILabel     *labelDelete;
@property (nonatomic,strong)UILabel     *labelMore;
@property (nonatomic,strong)UILabel     *labelStatus;

@property (nonatomic,strong)YHWorkGroupRepostView *repostView;
@property (nonatomic,strong)HKPBotView  *viewBottom;
@property (nonatomic,strong)UIView      *viewSeparator;

@end

@implementation CellForWorkGroupRepost

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    self.imgvAvatar = [UIImageView new];
    [self.contentView addSubview:self.imgvAvatar];
    
    self.labelName  = [UILabel new];
    self.labelName.font = [UIFont systemFontOfSize:14.0f];
    self.labelName.textColor = RGB16(0x303030);
    [self.contentView addSubview:self.labelName];
    
    self.labelIndustry = [UILabel new];
    self.labelIndustry.font = [UIFont systemFontOfSize:12.0f];
    self.labelIndustry.textColor = RGB16(0x303030);
    [self.contentView addSubview:self.labelIndustry];
    
    self.labelPubTime = [UILabel new];
    self.labelPubTime.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:self.labelPubTime];
    
    self.labelCompany = [UILabel new];
    self.labelCompany.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.labelCompany];
    
    self.labelJob = [UILabel new];
    self.labelJob.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.labelJob];
    
    self.labelContent = [UILabel new];
    self.labelContent.font = [UIFont systemFontOfSize:12.0f];
    self.labelContent.numberOfLines = 0;
    [self.contentView addSubview:self.labelContent];
    
    self.labelDelete = [UILabel new];
    self.labelDelete.font = [UIFont systemFontOfSize:12.0f];
    self.labelDelete.textColor = RGB16(0x303030);
    [self.contentView addSubview:self.labelDelete];
    
    self.labelMore = [UILabel new];
    self.labelMore.font = [UIFont systemFontOfSize:12.0f];
    self.labelMore.textColor = RGB16(0x303030);
    [self.contentView addSubview:self.labelMore];
    
    self.labelStatus = [UILabel new];
    self.labelStatus.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.labelStatus];
    
    self.repostView = [YHWorkGroupRepostView new];
    [self.contentView addSubview:self.repostView];
    
    self.viewBottom = [HKPBotView new];
    [self.contentView addSubview:self.viewBottom];
    
    self.viewSeparator = [UIView new];
    self.viewSeparator.backgroundColor = RGBCOLOR(244, 244, 244);
    [self.contentView addSubview:self.viewSeparator];
    
    
    [self layoutUI];
    
}

- (void)layoutUI{
    __weak typeof(self)weakSelf = self;
    [self.imgvAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.width.height.mas_equalTo(45);
    }];
    
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.left.equalTo(weakSelf.imgvAvatar.mas_right).offset(10);
        make.right.equalTo(weakSelf.labelIndustry.mas_left).offset(-10);
    }];
    
    
    [self.labelIndustry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.labelName.mas_bottom);
        make.left.equalTo(weakSelf.labelName.mas_right).offset(10);
        make.right.equalTo(weakSelf.labelPubTime.mas_left).offset(-10);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
    
    [self.labelIndustry setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelIndustry setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.labelPubTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.labelName.mas_bottom);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    [self.labelPubTime setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelPubTime setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [self.labelCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.labelName.mas_bottom).offset(9);
        make.left.equalTo(weakSelf.labelName.mas_left);
        make.right.equalTo(weakSelf.labelJob.mas_left).offset(-10);
    }];
    
    [self.labelJob mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.labelCompany.mas_bottom);
        make.left.equalTo(weakSelf.labelCompany.mas_right).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.width.mas_greaterThanOrEqualTo(80);
    }];
    
    [self.labelJob setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelJob setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgvAvatar.mas_bottom).offset(11);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.labelDelete.mas_top).offset(-11);
    }];
    
    // 不然在6/6plus上就不准确了
    self.labelContent.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    
    [self.labelDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.labelContent.mas_bottom).offset(11);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.labelMore.mas_left).offset(-10);
    }];
    
    [self.labelMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.labelDelete.mas_centerY);
        make.left.equalTo(weakSelf.labelDelete.mas_right).offset(10);
    }];
    
    [self.labelStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.centerY.equalTo(weakSelf.labelMore);
    }];
    
    [self.repostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.labelDelete.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.contentView).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    
    [self.viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.repostView.mas_bottom).offset(15).priorityLow();
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.viewSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.viewBottom.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(weakSelf.contentView);
    }];
    
}

- (void)setModel:(YHWorkGroup *)model{
    _model = model;
    [self.imgvAvatar sd_setImageWithURL:_model.userInfo.avatarUrl placeholderImage:[UIImage imageNamed:@"common_avatar_120px"]];
    self.labelName.text     = _model.userInfo.userName;
    self.labelIndustry.text = _model.userInfo.industry;
    self.labelPubTime.text  = _model.publishTime;
    self.labelCompany.text  = _model.userInfo.company;
    self.labelJob.text      = _model.userInfo.job;
    self.labelContent.text  = _model.msgContent;
    self.labelDelete.text   = @"删除";
    self.labelMore.text     = @"查看全部";
    
    self.repostView.forwardModel = _model.forwardModel;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
