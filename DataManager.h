//
//  DataManager.h
//  RHProjectDemo
//
//  Created by Young Die on 2016/12/15.
//  Copyright © 2016年 RHCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
//block回调传值
/**
 *   请求成功回调json数据
 *
 *  @param json json串
 */
typedef void(^Success)(id json);
/**
 *  请求失败回调错误信息
 *
 *  @param error error错误信息
 */
typedef void(^Failure)(NSError *error);

/**
 上传图片的请求体
 */
typedef void(^RequestBody) (id requestBody);
//单利方法
+ (DataManager *)dataManager;

/**
 post网络请求的方法，AF的网路请求方法

 @param URLString 请求地址
 @param successBlock 成功后的返回
 @param failureBlock 失败后的返回
 */
-(void)postObjectWithURLString:(NSString *)URLString parameters:(NSDictionary *)paramters completeBlock:(Success)successBlock errorBlock:(Failure)failureBlock;

/**
 get网络请求方法

 @param URLString 地址
 @param paramters 参数
 @param successBlock 成功后的block
 @param failureBlock 失败后的block
 */
-(void)getObjectWithURLString:(NSString *)URLString parameters:(NSDictionary *)paramters completeBlock:(Success)successBlock errorBlock:(Failure)failureBlock;


/**
 上传图片的方法

 @param URLString 地址
 @param params 入参
 @param requestBody 请求体：图片在这里处理
 @param successBlock 成功了的block
 @param failureBlock 失败的block
 */
- (void)postObjectWithURLString:(NSString *)URLString params:(id)params RequestBody:(RequestBody)requestBody completeBlock:(Success)successBlock errorBlock:(Failure)failureBlock;
@end
