//
//  AdvModel.h
//  HelloSunshine
//
//  Created by Maobai on 16/5/5.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuestionModel.h"
#import "RecommendGoodsModel.h"

@interface AritcleModel : NSObject


@property(nonatomic,retain) NSString *pic;
@property(nonatomic,retain) NSString *theId;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *subTitle;
@property(nonatomic,retain) NSString *content;
@property(nonatomic,retain) QuestionModel *question;
@property(nonatomic,retain) NSArray *goods;

@end
