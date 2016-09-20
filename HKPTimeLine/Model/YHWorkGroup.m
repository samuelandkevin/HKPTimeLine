//
//  YHWorkGroup.m
//  PikeWay
//
//  Created by YHIOS002 on 16/5/5.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "YHWorkGroup.h"
#import <UIKit/UIKit.h>


@implementation YHWorkGroup
{
    CGFloat _lastContentWidth;
}

const CGFloat contentLabelFontSize = 13.0;
CGFloat maxContentLabelHeight = 0;  //根据具体font而定
CGFloat maxContentRepostLabelHeight = 0;
CGFloat kMarginContentLeft    = 10; //动态内容左边边距
CGFloat kMarginContentRight   = 10; //动态内容右边边边距
const CGFloat deleteBtnHeight = 30;
const CGFloat deleteBtnWidth  = 60;
const CGFloat moreBtnHeight   = 30;
const CGFloat moreBtnWidth    = 60;

@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - kMarginContentLeft - kMarginContentRight ;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (!_isRepost)
        {
          
            if (textRect.size.height > maxContentLabelHeight) {
                _shouldShowMoreButton = YES;
            } else {
                _shouldShowMoreButton = NO;
            }
        }
        else{
        
            if (textRect.size.height > maxContentRepostLabelHeight)
            {
                _shouldShowMoreButton = YES;
            } else {
                _shouldShowMoreButton = NO;
            }
        }
       
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

@end
