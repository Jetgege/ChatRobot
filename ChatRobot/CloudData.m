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
    //[query orderByAscending:@"createdAt"];
    [query orderByDescending:@"createdAt"];
    [query orderByDescending:@"createdAt"];
    [query orderByDescending:@"createdAt"];
    // 获取数据
    [query setCachePolicy:kAVCachePolicyNetworkElseCache];//查询行为先尝试从网络加载，若加载失败，则从缓存加载结果
   [query setMaxCacheAge: 60*3];//缓存时间3min

   query.limit = 20; // 最多返回 20 条结果
    
  //  NSMutableArray *array = [NSMutableArray array];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //[query orderByAscending:@"createdAt"];
//        for (AVQuery *object in objects) {
//            [array addObject:object];
//        }
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
    [model setObject:chatModel.url forKey:@"url"];
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
