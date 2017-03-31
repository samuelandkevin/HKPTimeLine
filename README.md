# HKPTimeLine
## description
 [MyCSDN: iOS-仿赤兔、新浪微博动态列表（带评论、点赞、转发和分享,自动计算行高功能](http://blog.csdn.net/samuelandkevin/article/details/53186368)<br/>
 项目中使用到的第三方框架有:Masonry，FDTemplateLayoutCell，SDWebImage<br/>
#### 文件结构:
 <img src="http://img.blog.csdn.net/20161116145650103?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "160" height = "258" alt="pic1"
align=center /> <br>
#### 数据源:
项目中的数据来源不是来自公司服务器，是通过函数随机产生。以下这部分代码大家可以在实际开发中通过后台服务器获取的数据代替。<br>
```
- (void)randomModel:(YHWorkGroup *)model totalCount:(int)totalCount{
    model.type = arc4random()%totalCount %2? DynType_Forward:DynType_Original;
    if (model.type == DynType_Forward) {
        model.forwardModel = [YHWorkGroup new];
        [self creatOriModel:model.forwardModel totalCount:totalCount];
    }
    [self creatOriModel:model totalCount:totalCount];  
}
```
#### 动态首页:
动态首页所涉及的View使用简要说明:<br>
 <img src="http://img.blog.csdn.net/20161116151115093?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "568" height = "568" alt="pic2"
align=center /> <br>
使用Masorny布局时要打开符号断点:<br>
<img src="http://img.blog.csdn.net/20161116151851300?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "568" height = "150" alt="pic3"
align=center /> <br>
#### 行高计算:
<img src="http://img.blog.csdn.net/20161116152859177?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "500" height = "300" alt="pic4"
align=center /> <br>
#### 效果图:
<img src="http://img.blog.csdn.net/20161116153510404?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic5"
align=center /> <img src="http://img.blog.csdn.net/20161116153538041?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic6"
align=center /> <img src="http://img.blog.csdn.net/20161116153603983?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic7"
align=center /> <img src="http://img.blog.csdn.net/20161116153630525?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic8"
align=center /> <br>

你的支持，我的动力！
