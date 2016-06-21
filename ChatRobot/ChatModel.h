//
//  ChatModel.h
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ChatUserType){
    ChatUserTypeOther,
    ChatUserTypeMe,
};

@interface ChatModel : NSObject

@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,assign)NSInteger type;

-(instancetype)initWithDict:(NSDictionary*)dict;
-(instancetype)initWithObj:(AVObject*)object;
+(instancetype)chatModelWithDict:(NSDictionary*)dict;
@end
