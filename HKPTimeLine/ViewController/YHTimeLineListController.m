//
//  YHQAListController.m
//  PikeWay
//
//  Created by YHIOS002 on 16/8/29.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "YHTimeLineListController.h"
#import "CellForWorkGroup.h"
#import "CellForWorkGroupRepost.h"
#import "YHRefreshTableView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YHWorkGroup.h"
#import "YHUserInfoManager.h"
#import "HHUtils.h"

@interface YHTimeLineListController ()<UITableViewDelegate,UITableViewDataSource,CellForWorkGroupDelegate,CellForWorkGroupRepostDelegate>{
    int _currentRequestPage; //当前请求页面
    BOOL _reCalculate;
}



@property (nonatomic,strong) YHRefreshTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation YHTimeLineListController


- (void)viewDidLoad{
    [self initUI];
    [self requestDataLoadNew:YES];
    //kun调试用
    [YHUserInfoManager sharedInstance].userInfo.uid = @"1";
}

- (void)initUI{
    
    self.title = @"朋友圈";
    
    self.tableView = [[YHRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBCOLOR(244, 244, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    [self.tableView setEnableLoadNew:YES];
    [self.tableView setEnableLoadMore:YES];
    
    self.view.backgroundColor = RGBCOLOR(244, 244, 244);
    
    [self.tableView registerClass:[CellForWorkGroup class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    [self.tableView registerClass:[CellForWorkGroupRepost class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroupRepost class])];
}


#pragma mark - Lazy Load
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    //原创cell
    Class currentClass  = [CellForWorkGroup class];
    YHWorkGroup *model  = self.dataArray[indexPath.row];
    
    //转发cell
    if (model.type == DynType_Forward) {
        currentClass = [CellForWorkGroupRepost class];//第一版没有转发,因此这样稍该一下
    }
    cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    
    CellForWorkGroup  *cell1 = nil;//原创
    CellForWorkGroupRepost *cell2 = nil;//转发
    /*******原创Cell*******/
    if ([cell isMemberOfClass:[CellForWorkGroup class]]) {
        cell1 = (CellForWorkGroup *)cell;
        cell1.indexPath = indexPath;
        cell1.model = model;
        cell1.delegate = self;
        return cell1;
        
    }else{
        /*****转发cell******/
        cell2 = (CellForWorkGroupRepost *)cell;
        cell2.indexPath = indexPath;
        cell2.model = model;
        cell2.delegate = self;
        return cell2;
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (indexPath.row < self.dataArray.count) {
        
        //原创cell
        Class currentClass  = [CellForWorkGroup class];
        YHWorkGroup *model  = self.dataArray[indexPath.row];
        
        //转发cell
        if (model.type == DynType_Forward) {
            currentClass = [CellForWorkGroupRepost class];//第一版没有转发,因此这样稍该一下
            return [self.tableView fd_heightForCellWithIdentifier:@"CellForWorkGroupRepost" configuration:^(CellForWorkGroupRepost *cell) {
                [self configureRepostCell:cell atIndexPath:indexPath];
            }];
        }
        else{
            return [self.tableView fd_heightForCellWithIdentifier:@"CellForWorkGroup" configuration:^(CellForWorkGroup *cell) {
                [self configureOriCell:cell atIndexPath:indexPath];
            }];
           
        }
    }
    else{
        return 44.0f;
    }
}

- (void)configureOriCell:(CellForWorkGroup *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (indexPath.row < _dataArray.count) {
        cell.model = _dataArray[indexPath.row];
    }
    
}

- (void)configureRepostCell:(CellForWorkGroupRepost *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (indexPath.row < _dataArray.count) {
        cell.model = _dataArray[indexPath.row];
    }
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}

#pragma mark - 网络请求
- (void)requestDataLoadNew:(BOOL)loadNew{
    YHRefreshType refreshType;
    if (loadNew) {
        _currentRequestPage = 1;
        refreshType = YHRefreshType_LoadNew;
        [self.tableView setNoMoreData:NO];
    }
    else{
        _currentRequestPage ++;
        refreshType = YHRefreshType_LoadMore;
    }

    [self.tableView loadBegin:refreshType];
    if (loadNew) {
        [self.dataArray removeAllObjects];
    }
   
    int totalCount = 10;
    for (int i=0; i<totalCount; i++) {
        YHWorkGroup *model = [YHWorkGroup new];
        [self randomModel:model totalCount:totalCount];
        [self.dataArray addObject:model];
    }
    
    [self.tableView loadFinish:refreshType];
    [self.tableView reloadData];
    
}

#pragma mark - 模拟产生数据源
- (void)randomModel:(YHWorkGroup *)model totalCount:(int)totalCount{
    
    model.type = arc4random()%totalCount %2? DynType_Forward:DynType_Original;
//    model.type = DynType_Forward;//kun调试
    if (model.type == DynType_Forward) {
        model.forwardModel = [YHWorkGroup new];
        [self creatOriModel:model.forwardModel totalCount:totalCount];
    }
    [self creatOriModel:model totalCount:totalCount];
    
}

- (void)creatOriModel:(YHWorkGroup *)model totalCount:(int)totalCount{
    YHUserInfo *userInfo = [YHUserInfo new];
    model.userInfo = userInfo;
    model.userInfo.avatarUrl = [NSURL URLWithString:@""];
    
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
        [jStr appendString: @"测试职位"];
    }
    model.userInfo.job = jStr;
    
    CGFloat qlength = arc4random() % totalCount + 5;
//    qlength = 1;//kun调试
    NSMutableString *qStr = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < qlength; ++i) {
        [qStr appendString:@"测试数据很长，测试数据很长."];
    }
    model.msgContent = qStr;
    model.publishTime = @"2013-04-17";
    
    
    CGFloat picLength = arc4random() % 9;
    NSMutableArray *oriPArr = [NSMutableArray new];
    NSMutableArray *thumbPArr = [NSMutableArray new];
    for (int i = 0; i < picLength; i++) {
        [oriPArr addObject:[NSURL URLWithString:@"http://www.baidu.com"]];
        [thumbPArr addObject:[NSURL URLWithString:@"http://www.baidu.com"]];
    }
    model.originalPicUrls = oriPArr;
    model.thumbnailPicUrls = thumbPArr;
}

#pragma mark - YHRefreshTableViewDelegate
- (void)refreshTableViewLoadNew:(YHRefreshTableView*)view{
    [self requestDataLoadNew:YES];
}

- (void)refreshTableViewLoadmore:(YHRefreshTableView*)view{
    [self requestDataLoadNew:NO];
}


#pragma mark - CellForWorkGroupDelegate
- (void)onMoreInCell:(CellForWorkGroup *)cell{
    DDLog(@"查看详情");
    if (cell.indexPath.row < [self.dataArray count]) {
        YHWorkGroup *model = self.dataArray[cell.indexPath.row];
        model.isOpening = !model.isOpening;
        [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}

- (void)onCommentInCell:(CellForWorkGroup *)cell{

}

- (void)onLikeInCell:(CellForWorkGroup *)cell{

}

- (void)onShareInCell:(CellForWorkGroup *)cell{

}

- (void)onAvatarInCell:(CellForWorkGroup *)cell{

}

- (void)onDeleteInCell:(CellForWorkGroup *)cell{
    if (cell.indexPath.row < [self.dataArray count]) {
        [self _deleteDynAtIndexPath:cell.indexPath dynamicId:cell.model.dynamicId];
    }
}

#pragma mark - CellForWorkGroupRepostDelegate
- (void)onTapRepostViewInCell:(CellForWorkGroupRepost *)cell{
}

- (void)onCommentInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onLikeInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onShareInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onDeleteInRepostCell:(CellForWorkGroupRepost *)cell{
    if (cell.indexPath.row < [self.dataArray count]) {
        [self _deleteDynAtIndexPath:cell.indexPath dynamicId:cell.model.dynamicId];
    }
}

- (void)onMoreInRespostCell:(CellForWorkGroupRepost *)cell{
    if (cell.indexPath.row < [self.dataArray count]) {
        YHWorkGroup *model = self.dataArray[cell.indexPath.row];
        model.isOpening = !model.isOpening;
        [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - private
- (void)_deleteDynAtIndexPath:(NSIndexPath *)indexPath dynamicId:(NSString *)dynamicId{
    
    WeakSelf
    [HHUtils showAlertWithTitle:@"删除动态" message:@"您确定要删除此动态?" okTitle:@"确定" cancelTitle:@"取消" inViewController:self dismiss:^(BOOL resultYes) {
        
        if (resultYes)
        {

            DDLog(@"delete row is %ld",(long)indexPath.row);
                    
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
     
            [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
   
        }
    }];
    
}

#pragma mark - UIScrollViewDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
