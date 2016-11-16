//
//  YHWorkGroup.m
//  github:  https://github.com/samuelandkevin
//  CSDN:  http://blog.csdn.net/samuelandkevin
//  Created by samuelandkevin on 16/5/5.
//  Copyright © 2016年 HKP. All rights reserved.
//

#import "YHWorkGroup.h"
#import <UIKit/UIKit.h>


extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;
extern CGFloat maxContentRepostLabelHeight;
extern const CGFloat kMarginContentLeft;
extern const CGFloat kMarginContentRight;

@implementation YHWorkGroup
{
    CGFloat _lastContentWidth;
}



@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = SCREEN_WIDTH - kMarginContentLeft - kMarginContentRight ;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (!_isRepost)
        {
          
            if (textRect.size.height > maxContentLabelHeight+contentLabelFontSize) {
                _shouldShowMoreButton = YES;
            } else {
                _shouldShowMoreButton = NO;
            }
        }
        else{
        
            if (textRect.size.height > maxContentRepostLabelHeight+contentLabelFontSize)
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
