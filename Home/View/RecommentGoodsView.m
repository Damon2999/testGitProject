//
//  RecommentGoodsView.m
//  HelloSunshine
//
//  Created by damon on 16/7/14.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "RecommentGoodsView.h"
#import "RecommendGoodsModel.h"

@implementation RecommentGoodsView {

    UIView *conteView;

}

-(instancetype)init{

    self = [super init] ;
    if (self) {
        [self initContentViews];
    }
    
    return self;



}


-(void)initContentViews{
    UIScrollView *scrollview = [UIScrollView new];
    [self addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.with.height.equalTo(self);
    }];
    scrollview.showsHorizontalScrollIndicator = NO;
    conteView = [UIView new];
    [scrollview addSubview:conteView];
    [conteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.height.equalTo(scrollview);
    }];

}




-(void)setGoodsModels:(NSArray *)goodsModels{
    
    [conteView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIButton *lastBtn = nil;
    NSInteger index = 0;
    for (RecommendGoodsModel *model in goodsModels ) {
        index++;
        UIButton *button = [UIButton new];
        [conteView addSubview:button];
        UIImageView *image = [UIImageView new];
        UILabel *title = [AppTool label:model.title textColor:color_text_main font:14 lines:1];
        title.textAlignment = NSTextAlignmentCenter;
        title.adjustsFontSizeToFitWidth = YES;
        [button addSubview:image];
        [button addSubview:title];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right);
                
            }else{
                make.left.equalTo(conteView);
            
            }
            
            make.height.centerY.equalTo(conteView);
            make.width.equalTo(conteView.mas_height);
            
            if (index == goodsModels.count) {
                make.right.equalTo(conteView.mas_right);
            }
            
        }];
        lastBtn = button;
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(button.mas_bottom).offset(-2);
            make.left.centerX.width.equalTo(button);
        }];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(title.mas_top).offset(-5);
            make.top.equalTo(button);
            make.centerX.equalTo(button);
            make.left.equalTo(button.mas_left).offset(5);
            make.right.equalTo(button.mas_right).offset(-5);
        }];
        
        
        [image sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (self.didselectGoods) {
                self.didselectGoods(model.theId);
            }
            
        }];
        
        
        
    }



}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
