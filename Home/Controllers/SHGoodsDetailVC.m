//
//  SHGoodsDetailVC.m
//  HelloSunshine
//
//  Created by damon on 16/7/16.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "SHGoodsDetailVC.h"
#import "MyDefineButton.h"

@implementation SHGoodsDetailVC


-(void)initSomething{
    [super initSomething];
    
    self.title = @"商品详情";
    
    
    
    
    
    UIView  *bottomView = [UIView new];
    NSArray *titles = @[@"加入心愿单",@"收藏",@"立即兑换"];
    MyDefineButton *button0 = [[MyDefineButton alloc] initWithTitleFont:16 andTitleratio:0.7];
    [button0 setimage:@"common_icon_comment" selectImage:@"common_icon_hot" title:titles[0] tag:1000 normalCol:color_text_main selectedCor:color_blue];
    button0.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    MyDefineButton *button1 = [[MyDefineButton alloc] initWithTitleFont:16 andTitleratio:0.7];
    [button1 setimage:@"common_icon_comment" selectImage:@"common_icon_hot" title:titles[1] tag:1001 normalCol:color_text_main selectedCor:color_blue];
    
    MyDefineButton *button2 = [[MyDefineButton alloc] initWithTitleFont:16 andTitleratio:0.7];
    [button2 setimage:@"common_icon_comment" selectImage:@"common_icon_hot" title:titles[2] tag:1002 normalCol:color_text_main selectedCor:color_blue];
    

    [AppTool addSubViews:@[button0,button1,button2] to:bottomView];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = HEXCOLOR(0xeeeeee);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.bottom.equalTo(self.view)  ;
        make.height.equalTo(@55);
    }];
    
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bottomView);
        make.centerY.equalTo(bottomView);
        make.width.equalTo(bottomView.mas_width).multipliedBy(1.0/3.0);
        
    }];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bottomView);
        make.centerY.equalTo(bottomView);
        make.width.equalTo(bottomView.mas_width).multipliedBy(1.0/3.0);
    }];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bottomView);
        make.centerY.equalTo(bottomView);
        make.width.equalTo(bottomView.mas_width).multipliedBy(1.0/3.0);
    }];
    [bottomView distributeSpacingHorizontallyWith:@[button0,button1,button2]];
    
    
    [[RACSignal merge:@[[button0 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [button1 rac_signalForControlEvents:UIControlEventTouchUpInside],
                        [button2 rac_signalForControlEvents:UIControlEventTouchUpInside]]]
     subscribeNext:^(UIButton *x) {
        
         [SVProgressHUD showSuccessWithStatus:x.titleLabel.text];
        
    }];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
