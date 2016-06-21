//
//  NetWorkTool.h
//  ChatRobot
//
//  Created by Jet on 16/6/21.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatModel.h"
@interface NetWorkTool : NSObject


+(void)post:(NSString*)chatText andFinish:(void (^)(NSDictionary * dict, NSError *error))finished;
@end
