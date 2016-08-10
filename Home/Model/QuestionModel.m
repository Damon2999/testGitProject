//
//  AdvModel.m
//  HelloSunshine
//
//  Created by Maobai on 16/5/5.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"theId" : @"id",
             @"title" : @"title",
             @"anwser" : @"anwser"
             };
    
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [NSString class]
             };
}


@end
