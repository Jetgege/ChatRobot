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

//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//}
+(instancetype)chatModelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}
@end
