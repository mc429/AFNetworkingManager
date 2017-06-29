//
//  DataManager.m
//  RHProjectDemo
//
//  Created by Young Die on 2016/12/15.
//  Copyright © 2016年 RHCompany. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
static DataManager *manager = nil;
static AFHTTPSessionManager *afnManager = nil;
@implementation DataManager
+(DataManager *)dataManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return manager;
}

- (void)postObjectWithURLString:(NSString *)URLString parameters:(NSDictionary *)paramters completeBlock:(Success)successBlock errorBlock:(Failure)failureBlock{
    
    //首先判断是否有网路
    if (![PublicMethord networkOfInterpretation]) {
        
        return;
        
    }else{
        
        [afnManager POST:URLString parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            if (responseObject) {
                
               successBlock(responseObject);
                
            }else{
            
                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error.userInfo]];
            
        }];
   
        
    }
}

-(void)getObjectWithURLString:(NSString *)URLString parameters:(NSDictionary *)paramters completeBlock:(Success)successBlock errorBlock:(Failure)failureBlock {
    
    //首先判断是否有网络
    if (![PublicMethord networkOfInterpretation]) {
        
        return;
        
    }else{
        
        [afnManager GET:URLString parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            if (responseObject) {
                
                successBlock(responseObject);
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            failureBlock(error);
            
           [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error.userInfo]];
            
        }];
        
    }
    
}

- (void)postObjectWithURLString:(NSString *)URLString params:(id)params RequestBody:(RequestBody)requestBody completeBlock:(Success)successBlock errorBlock:(Failure)failureBlock{
    
    if (![PublicMethord networkOfInterpretation]) {
        
        return;
        
    }else{
        
      [afnManager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
          
          requestBody(formData);
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          
          if (responseObject) {
              
              successBlock(responseObject);
              
          }else{
              
              [SVProgressHUD showErrorWithStatus:@"暂无数据"];
              
          }
          
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
          failureBlock(error);
          
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error.userInfo]];
          
          
      }];
        
    }
    
}
@end
