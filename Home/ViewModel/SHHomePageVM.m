//
//  SHHomePageVM.m
//  HelloSunshine
//
//  Created by Maobai on 16/7/12.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "SHHomePageVM.h"

@implementation SHHomePageVM




-(RACSignal *)requestArticleDatas{

    [SVProgressHUD show];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [LSHttpKit postMethod:@"" parameters:@{
                                              @"":@"",
                                              @"":@"",
                                              @"":@"",
                                              @"":@""
                                              }
              success:^(NSURLSessionDataTask *t, id responseObject) {
                          
                      [SVProgressHUD dismiss];
                      
                      NSArray *datas = responseObject[@"datas"];
                      if ([datas isKindOfClass:[NSArray class]]) {
//                          for (NSDictionary *dict in datas) {
//                              
//                          }
                          
                          [subscriber sendNext:self.dataSource];
                          [subscriber sendCompleted];
                          
                      }
                          
              } failed:^(NSURLSessionDataTask *t, NSError *e) {
                  
                      [SVProgressHUD dismiss];
                      [subscriber sendError:e];
                      
              }];
        
        
        
        
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    


}






-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    
    return _dataSource;
    
}




@end
