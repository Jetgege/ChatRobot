//
//  NetWorkTool.m
//  ChatRobot
//
//  Created by Jet on 16/6/21.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "NetWorkTool.h"
//#import "AFHTTPSessionManager.h"
@implementation NetWorkTool

+(void)post:(NSString*)chatText andFinish:(void (^)(NSDictionary * dict, NSError *error))finished
{
    //1.创建AFHTTPSessionManager管理者
    //AFHTTPSessionManager内部是基于NSURLSession实现的
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://www.tuling123.com/openapi/api";
    //2.发送请求
    NSDictionary *param = @{
                            @"key":@"5ce9bb94ff9ffbbda1084ec6dba46c08",
                            @"info":chatText,
                            @"userid":@"jetgege"
                            };
    
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask *  task, id  responseObject) {
        
        finished(responseObject ,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(nil,error);
    }];
}
@end
