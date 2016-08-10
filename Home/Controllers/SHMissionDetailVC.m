//
//  MissionListVC.m
//  HelloSunshine
//
//  Created by Maobai on 16/7/12.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "SHMissionDetailVC.h"

#define CELLIDENTIFIER @"MissionListItemCell"


@interface SHMissionDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SHMissionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
}



-(void)initSomething{

    [super initSomething];
    self.title = @"任务详情";
    
    UIImageView *image = [UIImageView new];
    UILabel *title = [AppTool label:@"下载哎哟阳光APP" textColor:color_text_main font:16 lines:0];
    UILabel *subTitle = [AppTool label:@"邀请您的好友一起参加阳光圈，可以获得奖励" textColor:color_text_sub font:14 lines:0];
    UILabel *aword = [AppTool label:@"100阳光币" textColor:color_text_sub font:12 lines:0];
    UIButton *getButton = [UIButton new];
    getButton.layer.cornerRadius = 5.0f;
    getButton.backgroundColor = HEXCOLOR(0xcccccc);
    [getButton setTitleColor:color_text_main forState:UIControlStateNormal];
    [getButton setTitle:@"完成任务" forState:UIControlStateNormal];
    
    [AppTool addSubViews:@[image,title,subTitle,aword,getButton] to:self.view];
    
    
    image.backgroundColor = HEXCOLOR(0xeeeeee);
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(image.mas_width).multipliedBy(2.0/3.0);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(image);
        make.top.equalTo(image.mas_bottom).offset(10);
    
    }];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(image);
        make.top.equalTo(title.mas_bottom).offset(10);
        
    }];
    
    
    [aword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.equalTo(subTitle.mas_bottom).offset(20);
    }];
    
    [getButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@50);
    }];
    
    
    
    [[getButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[UIAlertView bk_showAlertViewWithTitle:@"" message:@"恭喜获得100阳光币" cancelButtonTitle:@"知道了" otherButtonTitles:nil handler:nil] show];
    }];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


}



//-(void)initSomething{
//    [super initSomething];
//
//    
//    [self creatTableView:CELLIDENTIFIER withDatasourceAndDelegate:self];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.width.equalTo(self.view);
//        
//    }];
//    
//    
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [SVProgressHUD showInfoWithStatus:@"刷新数据。。。"];
//        [self.tableView.header endRefreshing];
//        
//    }];
//    
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [SVProgressHUD showInfoWithStatus:@"加载更多数据。。。"];
//        [self.tableView.footer endRefreshing];
//    }];
//    
//
//
//}



#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 15;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [tableView fd_heightForCellWithIdentifier:CELLIDENTIFIER cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        if ([cell respondsToSelector:@selector(setModel:)]) {
            [cell performSelector:@selector(setModel:) withObject:nil];
        }
        
    }];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER];
    if ([cell respondsToSelector:@selector(setModel:)]) {
        [cell performSelector:@selector(setModel:) withObject:nil];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
