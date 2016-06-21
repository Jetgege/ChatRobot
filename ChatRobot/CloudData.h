//
//  CloudData.h
//  ChatRobot
//
//  Created by Jet on 16/6/21.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatModel;

@interface CloudData : NSObject
typedef void(^Finished)(NSArray *arry);

+(void)getDataFormCloud:(Finished)finished;
+(void)saveDataToCloud:(ChatModel*)chatModel;
@end
