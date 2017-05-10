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
<br>

使用Masorny布局时要打开符号断点:<br>
<img src="http://img.blog.csdn.net/20161116151851300?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "568" height = "150" alt="pic3"
align=center /> <br>
#### 行高计算:
```
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < self.dataArray.count) {
        CGFloat height = 0.0;
        //原创cell
        Class currentClass  = [CellForWorkGroup class];
        YHWorkGroup *model  = self.dataArray[indexPath.row];
        
        //取缓存高度
        NSDictionary *dict =  self.heightDict[model.dynamicId];
        if (dict) {
            if (model.isOpening) {
                height = [dict[@"open"] floatValue];
            }else{
                height = [dict[@"normal"] floatValue];
            }
            if (height) {
                return height;
            }
        }
        
        //转发cell
        if (model.type == DynType_Forward) {
            currentClass = [CellForWorkGroupRepost class];//第一版没有转发,因此这样稍该一下
            
            height = [CellForWorkGroupRepost hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                CellForWorkGroupRepost *cell = (CellForWorkGroupRepost *)sourceCell;
                cell.model = model;   
            }];
            
        }
        else{
            height = [CellForWorkGroup hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                CellForWorkGroup *cell = (CellForWorkGroup *)sourceCell;
                cell.model = model;
            }];
        }
        
        //缓存高度
        if (model.dynamicId) {
            NSMutableDictionary *aDict = [NSMutableDictionary new];
            if (model.isOpening) {
                [aDict setObject:@(height) forKey:@"open"];
            }else{
                [aDict setObject:@(height) forKey:@"normal"];
            }
            [self.heightDict setObject:aDict forKey:model.dynamicId];
        }
        return height;
    }
    else{
        return 44.0f;
    }
}

```
#### 效果图:
<img src="http://img.blog.csdn.net/20161116153510404?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic5"
align=center /> <img src="http://img.blog.csdn.net/20161116153603983?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic7"
align=center />   <img src="http://img.blog.csdn.net/20161116153630525?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" width = "320" height = "568" alt="pic8"
align=center /> <br>

你的支持，我的动力！
