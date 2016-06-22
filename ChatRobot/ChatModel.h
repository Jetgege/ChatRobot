//
//  ChatModel.h
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DateConvert;
typedef NS_ENUM(NSInteger,ChatUserType){
    ChatUserTypeOther,
    ChatUserTypeMe,
};

@interface ChatModel : NSObject
//记录机器人返回的url
@property(nonatomic,strong)NSString *url;
//聊天正文
@property(nonatomic,strong)NSString *text;
//聊天时间
@property(nonatomic,strong)NSString *time;
//发送文本的使用人
@property(nonatomic,assign)NSInteger type;
//记录创建时间
@property(nonatomic,strong)NSDate *dateTimes;
//隐藏时间lable的标记
@property(nonatomic,assign)BOOL *hidenTimeLabel;


-(instancetype)initWithDict:(NSDictionary*)dict;
-(instancetype)initWithObj:(AVObject*)object;
+(instancetype)chatModelWithDict:(NSDictionary*)dict;
@end
