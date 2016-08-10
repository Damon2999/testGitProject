//
//  RecommentGoodsView.h
//  HelloSunshine
//
//  Created by damon on 16/7/14.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommentGoodsView : UIView

@property(nonatomic,retain) NSArray * goodsModels;
@property(nonatomic,copy) void (^didselectGoods)(NSString *goodsId);



@end
