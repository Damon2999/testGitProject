//
//  AdvModel.m
//  HelloSunshine
//
//  Created by Maobai on 16/5/5.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "RecommendGoodsModel.h"

@implementation RecommendGoodsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"theId" : @"id",
             @"pic" : @"pic",
             @"title" : @"title"
             };
    
}

@end
