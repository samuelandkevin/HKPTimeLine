# HKPTimeLine
仿赤兔、新浪微博动态列表（带评论、点赞、转发和分享,自动计算行高功能）

 最近有空整理一下项目,做了一个仿赤兔、新浪微博动态列表（带评论、点赞、转发和分享,自动计算行高功能）的DEMO。HKPTimeLine   ,喜欢的可以star一下哦。 

       csdn  :  http://blog.csdn.net/samuelandkevin/article/details/53186368

       github:  https://github.com/samuelandkevin/HKPTimeLine

       使用到的第三方框架有:Masonry，FDTemplateLayoutCell，SDWebImage。

       对于像新浪微博复杂布局的cell，HKPTimeLine计算行高是采用了FDTemplateLayoutCell。利用Masonry进行布局。图像加载的是用到SDWebImage。

       HKPTimeLine使用经典的MVC设计,可以从工程文件夹命名看出。

                                                   
       DEMO的数据来源不是来自公司服务器，是通过函数随机产生，可以校验使用Masonry手写代码的AutoLayout是否有误。以下这部分代码大家可以在实际开发中通过后台服务器获取的数据代替。


## 模拟产生数据源
```  
-(void)randomModel:(YHWorkGroup *)model totalCount:(int)totalCount{  
      
    model.type = arc4random()%totalCount %2? 	DynType_Forward:DynType_Original;  
    if (model.type == DynType_Forward) {  
        model.forwardModel = [YHWorkGroup new];  
        [self creatOriModel:model.forwardModel totalCount:totalCount];  
    }  
    [self creatOriModel:model totalCount:totalCount];  
      
}  
  
-(void)creatOriModel:(YHWorkGroup *)model totalCount:(int)totalCount{  
    YHUserInfo *userInfo = [YHUserInfo new];  
    model.userInfo = userInfo;  
    NSArray *avtarArray = @[ 
    @"http://testapp.gtax.cn/images/2016/11/05/812eb442b6a645a99be476d139174d3c.png!m90x90.png",  
@"http://testapp.gtax.cn/images/2016/11/09/64a62eaaff7b466bb8fab12a89fe5f2f.png!m90x90.png",  
@"https://testapp.gtax.cn/images/2016/09/30/ad0d18a937b248f88d29c2f259c14b5e.jpg!m90x90.jpg",  
@"https://testapp.gtax.cn/images/2016/09/14/c6ab40b1bc0e4bf19e54107ee2299523.jpg!m90x90.jpg",  
@"http://testapp.gtax.cn/images/2016/11/14/8d4ee23d9f5243f98c79b9ce0c699bd9.png!m90x90.png",  
@"https://testapp.gtax.cn/images/2016/09/14/8cfa9bd12e6844eea0a2e940257e1186.jpg!m90x90.jpg"];  
    int avtarIndex = arc4random() % avtarArray.count;  
    if (avtarIndex < avtarArray.count) {  
        model.userInfo.avatarUrl = [NSURL URLWithString:avtarArray[avtarIndex]];  
    }  
        
    CGFloat myIdLength = arc4random() % totalCount;  
    int result = (int)myIdLength % 2;  
    model.userInfo.uid = result ?   [YHUserInfoManager sharedInstance].userInfo.uid:@"2";  
      
    CGFloat nLength = arc4random() % 3 + 1;  
    NSMutableString *nStr = [NSMutableString new];  
    for (int i = 0; i < nLength; i++) {  
        [nStr appendString: @"测试名字"];  
    }  
    model.userInfo.userName = nStr;  
      
    CGFloat iLength = arc4random() % 3 + 1;  
    NSMutableString *iStr = [NSMutableString new];  
    for (int i = 0; i < iLength; i++) {  
        [iStr appendString: @"测试行业"];  
    }  
    model.userInfo.industry = iStr;  
      
      
    CGFloat cLength = arc4random() % 8 + 1;  
    NSMutableString *cStr = [NSMutableString new];  
    for (int i = 0; i < cLength; i++) {  
        [cStr appendString: @"测试公司"];  
    }  
    model.userInfo.company  = cStr;  
      
      
    CGFloat jLength = arc4random() % 8 + 1;  
    NSMutableString *jStr = [NSMutableString new];  
    for (int i = 0; i < jLength; i++) {  
        [jStr appendString: @"随机职位"];  
    }  
    model.userInfo.job = jStr;  
      
    CGFloat qlength = arc4random() % totalCount + 5;  
    NSMutableString *qStr = [[NSMutableString alloc] init];  
    for (NSUInteger i = 0; i < qlength; ++i) {  
        [qStr appendString:@"测试数据很长，测试数据很长."];  
    }  
    model.msgContent = qStr;  
    model.publishTime = @"2013-04-17";  
      
      
    CGFloat picLength = arc4random() % 9;  
  
    //原图  
    NSArray *oriPName = @[  
@"https://testapp.gtax.cn/images/2016/08/25/2241c4b32b8445da87532d6044888f3d.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/0abd8670e96e4357961fab47ba3a1652.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/5cd8aa1f1b1f4b2db25c51410f473e60.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/5e8b978854ef4a028d284f6ddc7512e0.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/03c58da45900428796fafcb3d77b6fad.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/dbee521788da494683ef336432028d48.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/4cd95742b6744114ac8fa41a72f83257.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/4d49888355a941cab921c9f1ad118721.jpg",  
      
@"https://testapp.gtax.cn/images/2016/08/25/ea6a22e8b4794b9ba63fd6ee587be4d1.jpg"];  
      
    NSMutableArray *oriPArr = [NSMutableArray new];  
    for (NSString *pName in oriPName) {  
        [oriPArr addObject:[NSURL URLWithString:pName]];  
    }  
      
    //小图  
    NSArray *thumbPName = @[  
                             @"https://testapp.gtax.cn/images/2016/08/25/2241c4b32b8445da87532d6044888f3d.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/0abd8670e96e4357961fab47ba3a1652.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/5cd8aa1f1b1f4b2db25c51410f473e60.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/5e8b978854ef4a028d284f6ddc7512e0.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/03c58da45900428796fafcb3d77b6fad.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/dbee521788da494683ef336432028d48.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/4cd95742b6744114ac8fa41a72f83257.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/4d49888355a941cab921c9f1ad118721.jpg!t300x300.jpg",  
                               
                             @"https://testapp.gtax.cn/images/2016/08/25/ea6a22e8b4794b9ba63fd6ee587be4d1.jpg!t300x300.jpg"];  
      
    NSMutableArray *thumbPArr = [NSMutableArray new];  
    for (NSString *pName in thumbPName) {  
        [thumbPArr addObject:[NSURL URLWithString:pName]];  
    }  
  
    model.originalPicUrls = [oriPArr subarrayWithRange:NSMakeRange(0, picLength)];  
    model.thumbnailPicUrls = [thumbPArr subarrayWithRange:NSMakeRange(0, picLength)];  
}  
```
       DMEO中动态首页所涉及的View使用简要说明,如图
  布局中,可能会遇到约束冲突,可以打开符号断点，这样系统会提示开发中哪些约束冲突。

      
      对应多个控件水平排列,记得设计水平紧抱性(Content Hugging Priority)和水平抗压性（Content Compressing Resistance Priority）,垂直方向也如此。

       
       计算行高，调用了FDTemplateLayoutCell的API,
```
-(CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration;
```


    

  
