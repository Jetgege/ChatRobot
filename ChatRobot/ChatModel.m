//
//  ChatModel.m
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}

-(instancetype)initWithObj:(AVObject*)object{
    if (self =[super init]) {
        self.text = object[@"message"];
        self.time = object[@"time"];
        self.type = [object[@"type"] integerValue];
        self.url = object[@"url"];
//        //链接类/列车类/航班类
//        if (object[@"url"] != nil) {
//            self.url = object[@"url"];
//        }
//        //新闻类/菜谱类
//        if (object[@"list"] != nil) {
//           
//            if (object[@"list"][0][@"detailurl"] != nil) {
//                self.url = object[@"list"][0][@"detailurl"];
//            }
//        }
//        
//       
    }
    return  self;
}

//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//}
+(instancetype)chatModelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}
@end
