//
//  SHArticleDetailVC.m
//  HelloSunshine
//
//  Created by Maobai on 16/7/12.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "SHArticleListVC.h"
#import "RadioButton.h"
#import "AritcleModel.h"
#import "RecommentGoodsView.h"
#import "SHGoodsDetailVC.h"


static const CGFloat kSHPullDownThreshold = 50.0;

@interface SHArticleListVC () <UIScrollViewDelegate>

@property (nonatomic) BOOL isDragging;


@end

@implementation SHArticleListVC{
    
    

    //记录性对象
    UIScrollView *otherView;
    UIScrollView *currentView;
    UIScrollView *lowerView;
    NSInteger selectArticleIndex;
    UIScrollView *thirdScrollView;
    
    
    //文章信息
    UILabel *content;
    UIImageView *articleBgImage;
    UILabel *articleTitle;
    UILabel *articleSubTitle;
    UILabel *questionTitle;
    RadioButton *questionBtn0;
    RadioButton *questionBtn1;
    RadioButton *questionBtn2;
    RadioButton *questionBtn3;
    RecommentGoodsView *recomGoodsView;
    
    
}


-(void)initSomething{
    
    [super initSomething];
    

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"article" ofType:@"txt"];
    NSData *datas = [NSData dataWithContentsOfFile:plistPath];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableLeaves error:nil];
    NSArray *atricles = jsonDict[@"articles"];
    for (NSDictionary *dict in  atricles) {
        [self.dataListArr addObject:[AritcleModel yy_modelWithJSON:dict]];
    }

    
    content = [UILabel new];
    content.numberOfLines = 0;
    
    
    
    //布局底层三个scrollview，提交autolayout自适应
    UIScrollView *firstScrollView  = [[UIScrollView alloc] initWithFrame:
                                      CGRectMake(0, 0, self.view.frame.size.width, YGScreenHeight -(YGStatusBarH+YGNaviBarH+YGTabH))];
    UIScrollView *secondScrollView = [[UIScrollView alloc] initWithFrame:
                                      CGRectMake(0,  CGRectGetHeight(firstScrollView.frame), YGScreenWidth, CGRectGetHeight(firstScrollView.frame))];
    thirdScrollView  = [[UIScrollView alloc] initWithFrame:
                                      CGRectMake(0, -CGRectGetHeight(firstScrollView.frame), YGScreenWidth, CGRectGetHeight(firstScrollView.frame))];
    
    [AppTool addSubViews:@[firstScrollView,secondScrollView,thirdScrollView] to:self.view];
    firstScrollView.delegate = secondScrollView.delegate= thirdScrollView.delegate = self;
    firstScrollView.backgroundColor = secondScrollView.backgroundColor= thirdScrollView.backgroundColor = self.view.backgroundColor;
    
    currentView = firstScrollView;
    lowerView   = secondScrollView;
    otherView   = thirdScrollView;
    
    UIView *contentView1 = [UIView new];
    UIView *contentView2 = [UIView new];
    UIView *contentView3 = [UIView new];
    [firstScrollView    addSubview:contentView1];
    [secondScrollView   addSubview:contentView2];
    [thirdScrollView    addSubview:contentView3];
    
    [contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(firstScrollView);
        make.height.greaterThanOrEqualTo(@(CGRectGetHeight(firstScrollView.frame)+0.5));
    }];
    [contentView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(secondScrollView);
        make.height.greaterThanOrEqualTo(@(CGRectGetHeight(secondScrollView.frame)+0.5));
    }];
    
    [contentView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(thirdScrollView);
        make.height.greaterThanOrEqualTo(@(CGRectGetHeight(thirdScrollView.frame)+0.5));
    }];
    
    
    
    
    
    //文章标题页面
    articleBgImage = [[UIImageView alloc] initWithImage:YGIMAGE(@"launchim2")];
    [contentView1 addSubview:articleBgImage];
    articleBgImage.contentMode = UIViewContentModeScaleAspectFill;
    [articleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView1);
    }];
    
    articleTitle       = [AppTool label:@"我是文章标题" textColor:color_text_main font:24 lines:0];
    articleSubTitle    = [AppTool label:@"我是文章简介" textColor:HEXCOLOR(0x999999) font:18 lines:0];
    
    UIButton *collectBtn = [UIButton new];
    UIButton *shareBtn = [UIButton new];
    [collectBtn setImage:YGIMAGE(@"common_icon_positve") forState:UIControlStateNormal];
    [shareBtn setImage:YGIMAGE(@"common_icon_negative") forState:UIControlStateNormal];
    
    [AppTool addSubViews:@[articleTitle,articleSubTitle,collectBtn,shareBtn] to:contentView1];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.bottom.equalTo(@-20);
    }];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shareBtn);
        make.right.equalTo(shareBtn.mas_left).offset(-25);
    }];
    
    [articleSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(shareBtn.mas_top).offset(-20);
        make.left.equalTo(contentView1.mas_left).offset(20);
        make.right.equalTo(contentView1.mas_right).offset(-20);
    }];
    [articleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(articleSubTitle);
        make.bottom.equalTo(articleSubTitle.mas_top).offset(-20);
    }];
    
    
    
    
    
    //文章正文
    [contentView2 addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(contentView2.mas_bottom).offset(-10);
    }];
    
    
    
    
    
    //问答和推荐商品页面
    UIView *bgView0 = [UIView new];
    bgView0.backgroundColor = HEXCOLOR(0x999999);
    UILabel *question = [AppTool label:@"有奖问答" textColor:HEXCOLOR(0xffffff) font:16 lines:1];
    questionTitle = [AppTool label:@"文中提到的xxx是什么？" textColor:color_text_main font:16 lines:0];
  
    questionBtn0 = [RadioButton new];
    questionBtn1 = [RadioButton new];
    questionBtn2 = [RadioButton new];
    questionBtn3 = [RadioButton new];
    questionBtn0.marginWidth =  questionBtn1.marginWidth = 10 ;
    [questionBtn0 setTitle:@"1" forState:UIControlStateNormal];
    [questionBtn1 setTitle:@"2" forState:UIControlStateNormal];
    [questionBtn2 setTitle:@"3" forState:UIControlStateNormal];
    [questionBtn3 setTitle:@"4" forState:UIControlStateNormal];
    questionBtn0.titleLabel.font = questionBtn1.titleLabel.font = questionBtn2.titleLabel.font = questionBtn3.titleLabel.font =[UIFont systemFontOfSize:14];
    questionBtn0.iconColor = questionBtn1.iconColor = questionBtn2.iconColor =questionBtn3.iconColor = HEXCOLOR(0x82D0FD);
    questionBtn0.indicatorColor = questionBtn1.indicatorColor = questionBtn2.indicatorColor= questionBtn3.indicatorColor= HEXCOLOR(0x82D0FD);
        questionBtn0.otherButtons = @[questionBtn1,questionBtn2,questionBtn3];
    [questionBtn0 setTitleColor:color_text_main forState:UIControlStateNormal];
    [questionBtn1 setTitleColor:color_text_main forState:UIControlStateNormal];
    [questionBtn2 setTitleColor:color_text_main forState:UIControlStateNormal];
    [questionBtn3 setTitleColor:color_text_main forState:UIControlStateNormal];
    questionBtn0.contentHorizontalAlignment = questionBtn1.contentHorizontalAlignment = questionBtn2.contentHorizontalAlignment = questionBtn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [AppTool addSubViews:@[bgView0,question,questionTitle,questionBtn0,questionBtn1,questionBtn2,questionBtn3] to:contentView3];
    
    [bgView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView3.mas_left).offset(20);
        make.right.equalTo(contentView3.mas_right).offset(-20);
        make.height.equalTo(@40);
        
    }];
    [question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView0.mas_left).offset(10);
        make.centerY.equalTo(bgView0);
    }];
    [questionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView0.mas_bottom).offset(10);
        make.left.equalTo(question);
        make.right.equalTo(bgView0);
    }];
    [questionBtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question);
        make.right.equalTo(questionBtn1.mas_left).offset(-10);
        make.top.equalTo(questionTitle.mas_bottom).offset(15);
    }];
    [questionBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView3.mas_centerX).offset(20);
        make.centerY.equalTo(questionBtn0);
        make.right.equalTo(bgView0.mas_right).offset(-10);
    }];
    [questionBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(questionBtn0);
        make.top.equalTo(questionBtn0.mas_bottom).offset(20);
        
    }];
    [questionBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(questionBtn1);
        make.centerY.equalTo(questionBtn2);
    }];
    
    
    
    [[RACSignal merge:@[[questionBtn0 rac_signalForControlEvents:UIControlEventTouchUpInside],[questionBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside],[questionBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside],[questionBtn3 rac_signalForControlEvents:UIControlEventTouchUpInside]]] subscribeNext:^(UIButton *sender) {
        AritcleModel *model = self.dataListArr[selectArticleIndex];
        if ([sender.titleLabel.text isEqualToString:model.question.anwser]) {
            [SVProgressHUD showSuccessWithStatus:@"答对了，恭喜"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"呃欧，答错了"];
        
        }
    }];
    

    
    UIView *bgView1 = [UIView new];
    bgView1.backgroundColor = HEXCOLOR(0x999999);
    UILabel *recommend = [AppTool label:@"推荐商品" textColor:HEXCOLOR(0xffffff) font:16 lines:1];
    
    recomGoodsView = [[RecommentGoodsView alloc] init];
    
    UIButton *getMoreBtn = [UIButton new];
    getMoreBtn.backgroundColor = HEXCOLOR(0xbbbbbb);
    getMoreBtn.layer.cornerRadius = 10.0f;
    [getMoreBtn setTitle:@"获取更多奖励" forState:UIControlStateNormal];
    [getMoreBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getMoreBtn setTitleColor:HEXCOLOR(0xcccccc) forState:UIControlStateHighlighted];
    
    [AppTool addSubViews:@[recomGoodsView,bgView1,recommend,getMoreBtn] to:contentView3];
    
    
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(questionBtn3.mas_bottom).offset(20);
        make.left.right.height.equalTo(bgView0);
        make.bottom.equalTo(recomGoodsView.mas_top).offset(-10);
    }];
    [recommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1.mas_left).offset(10);
        make.centerY.equalTo(bgView1);
    }];
    
    [recomGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(getMoreBtn.mas_top).offset(-15);
        make.left.right.equalTo(bgView1);
        make.height.equalTo(@100);
    }];
    
    [getMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView1);
        make.bottom.equalTo(contentView3.mas_bottom).offset(-20);
        make.height.equalTo(@50);
    }];
    
    getWeakSelf(weakself);
    recomGoodsView.didselectGoods = ^(NSString *goodsId){
        NSLog(@"%@",goodsId);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"选择了%@",goodsId]];
        SHGoodsDetailVC   *gd = [SHGoodsDetailVC new];
        gd.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:gd animated:YES];
    
    };
    
    
    
    
    
    selectArticleIndex = 0;
    [self reloadNextArticleData];

}




#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.isDragging && self.scrollView.contentOffset.y >= 0) {
//        
//        NSNumber *percentage = [NSNumber numberWithFloat: 1.0 - (self.scrollView.contentOffset.y / kSHPullDownThreshold)];
//
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isDragging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.isDragging = NO;
    
    float totallHeight =(kSHPullDownThreshold + (scrollView.contentSize.height-1>CGRectGetHeight(scrollView.frame)?(scrollView.contentSize.height - CGRectGetHeight(scrollView.frame)):0));
    
    if(scrollView.contentOffset.y > totallHeight) {

        if (currentView == thirdScrollView) {
            if (selectArticleIndex>=self.dataListArr.count-1) {
                
                selectArticleIndex = 0;
                [UIAlertView bk_showAlertViewWithTitle:@"呃喔。。" message:@"看完了，继续就重复查看了哈？" cancelButtonTitle:@"知道了" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                }];
                
            }else{
                
                selectArticleIndex ++;
            
            }
            
            [self reloadNextArticleData];
        }
        

        [self updateViewLayouts];
           

    }
}



-(void)reloadNextArticleData{
    AritcleModel *model = selectArticleIndex<self.dataListArr.count?self.dataListArr[selectArticleIndex]:nil;
    if (model) {
        [articleBgImage sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        articleTitle.text = model.title;
        articleSubTitle.text = model.subTitle;
        
        content.text = model.content;
        questionTitle.text = model.question.title;
        
        NSString *q0 = 0<model.question.items.count?model.question.items[0]:nil;
        NSString *q1 = 1<model.question.items.count?model.question.items[1]:nil;
        NSString *q2 = 2<model.question.items.count?model.question.items[2]:nil;
        NSString *q3 = 3<model.question.items.count?model.question.items[3]:nil;
        
        [questionBtn0 setTitle:q0?q0:@"1" forState:UIControlStateNormal];
        [questionBtn1 setTitle:q1?q1:@"2" forState:UIControlStateNormal];
        [questionBtn2 setTitle:q2?q2:@"3" forState:UIControlStateNormal];
        [questionBtn3 setTitle:q3?q3:@"4" forState:UIControlStateNormal];
        
        questionBtn0.hidden = q0?NO:YES;
        questionBtn1.hidden = q1?NO:YES;
        questionBtn2.hidden = q2?NO:YES;
        questionBtn3.hidden = q3?NO:YES;
        questionBtn0.selected = questionBtn1.selected = questionBtn2.selected = questionBtn3.selected = NO;
        
        recomGoodsView.goodsModels = model.goods;
        
        
        
    }
   
   


}



-(void)updateViewLayouts{
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect tempFrame = currentView.frame;
        tempFrame.origin.y -= tempFrame.origin.y;
        currentView.frame = tempFrame;
        
        tempFrame = lowerView.frame;
        tempFrame.origin.y -= tempFrame.origin.y;
        lowerView.frame = tempFrame;
        [self.view bringSubviewToFront:lowerView];
        
    }completion:^(BOOL finished) {
        
        
        CGRect tempFrame = otherView.frame;
        tempFrame.origin.y = tempFrame.size.height;
        otherView.frame = tempFrame;
        
        UIScrollView *temp = currentView;
        currentView = lowerView;
        lowerView = otherView;
        otherView = temp;
        
        otherView.contentOffset = CGPointZero;
        
        
    }];
    


}






-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    self.title = @"文章";
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
