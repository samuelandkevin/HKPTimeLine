//
//  YHWorkGroupPhotoContainer.h
//  HKPTimeLine
//
//  Created by YHIOS002 on 16/9/20.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHWorkGroupPhotoContainer : UIView

@property (nonatomic, strong) NSArray *picUrlArray;//缩略图URL
@property (nonatomic, strong) NSArray *picOriArray;//原图url

- (instancetype)initWithWidth:(CGFloat)width;
@end
