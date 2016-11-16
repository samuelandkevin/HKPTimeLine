//
//  YHSharePresentView.h
//  PikeWay
//
//  Created by YHIOS002 on 16/10/27.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ShareType){
    ShareType_WorkGroup,//工作圈
    ShareType_Card,//名片
    ShareType_News//咨讯
};

typedef void(^DismissBlock)(BOOL isCanceled,NSInteger index);
@interface YHSharePresentView : UIView

//config arguments
@property (nonatomic,copy) NSArray *iconNameArray;
@property (nonatomic,copy) NSArray *itemNameArray;
@property (nonatomic,assign) CGFloat fontSize; //字体大小
@property (nonatomic,assign) CGFloat cancelBtnH;//取消按钮高度
@property (nonatomic,strong) UIColor *textColor;//字体颜色
@property (nonatomic,strong) UIColor *maskColor;//遮罩颜色
@property (nonatomic,strong) UIColor *popViewBGColor;//弹出视图背景颜色
@property (nonatomic,strong) UIColor *cancelBtnColor;//取消按钮颜色

@property (nonatomic,assign)ShareType shareType;//分享的类型。设置此属性就不用再设置 iconNameArray itemNameArray (可选属性)

- (void)show;
- (void)hide;

- (void)dismissHandler:(DismissBlock)handler;
@end
