//
//  MissionListVC.m
//  HelloSunshine
//
//  Created by Maobai on 16/7/12.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "SHMissionListVC.h"

#define CELLIDENTIFIER @"MissionListItemCell"
#define DETAILCONTROLLER @"SHMissionDetailVC"


@interface SHMissionListVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SHMissionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.title = @"任务";

}



-(void)initSomething{
    [super initSomething];

    
    [self creatTableView:CELLIDENTIFIER withDatasourceAndDelegate:self];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(self.view);
        
    }];
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [SVProgressHUD showInfoWithStatus:@"刷新数据。。。"];
        [self.tableView.header endRefreshing];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [SVProgressHUD showInfoWithStatus:@"加载更多数据。。。"];
        [self.tableView.footer endRefreshing];
    }];
      
    


}



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
    
    UIViewController *detail = [[NSClassFromString(DETAILCONTROLLER) alloc] init];
    if (detail) {
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
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
