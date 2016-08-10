//
//  AdvModel.m
//  HelloSunshine
//
//  Created by Maobai on 16/5/5.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "AritcleModel.h"

@implementation AritcleModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"theId" : @"id",
             @"pic" : @"pic",
             @"title" : @"title",
             @"subTitle" : @"subTitle",
             @"content" : @"content",
             @"question" : @"question",
             };
    
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods" : [RecommendGoodsModel class]
             };
}
@end

