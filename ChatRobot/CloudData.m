//
//  CloudData.m
//  ChatRobot
//
//  Created by Jet on 16/6/21.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "CloudData.h"
#import "ChatModel.h"


@implementation CloudData

+(void)getDataFormCloud:(Finished)finished{
    AVQuery *query = [AVQuery queryWithClassName:@"ChatModel"];//获取全部数据
    //按创建日期排序
    [query orderByAscending:@"createdAt"];
    // 获取缓存数据
    [query setCachePolicy:kAVCachePolicyCacheElseNetwork];//先从缓存中查找如果缓存中没有数据到网络中查找
   [query setMaxCacheAge: 60*3];//缓存时间3min
//   NSDate *now = [NSDate date];
//   [query whereKey:@"createdAt" greaterThanOrEqualTo:now];//查询今天之前创建
//    query.limit = 20; // 最多返回 20 条结果
    
    NSMutableArray *array = [NSMutableArray array];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (AVQuery *object in objects) {
            [array addObject:object];
        }
        finished(objects);
    }];

}
#pragma mark-
#pragma mark-保存数据到运端
+(void)saveDataToCloud:(ChatModel*)chatModel{
    AVObject *model = [[AVObject alloc] initWithClassName:@"ChatModel"];// 构建对象
    [model setObject:chatModel.time forKey:@"time"];// 设置名称
    [model setObject:chatModel.text forKey:@"message"];// 设置名称
    [model setObject:@(chatModel.type) forKey:@"type"];// 设置名称
    // 保存到云端
    [model saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            
            NSLog(@"保存成功！");
        }else{
            
            NSLog(@"%@",error.localizedDescription);
        }
        
    }];

}

@end
