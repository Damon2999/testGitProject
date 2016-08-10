//
//  LSHomeVC.m
//  YJTProject
//
//  Created by sliu on 15/9/27.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSHomeVC.h"
#import "SHArticleListVC.h"
#import "SHMissionListVC.h"

@interface LSHomeVC () 
{
    
}


@end

@implementation LSHomeVC


-(void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    SHArticleListVC *vc0 = [SHArticleListVC new];
    SHMissionListVC *vc1 = [SHMissionListVC new];
    
    self.contentDatas = @[vc0,vc1];
    
    
    
    
    
    
    
}


-(void)refreshHeaderAction{

    

}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


@end
