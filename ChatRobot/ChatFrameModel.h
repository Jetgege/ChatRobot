//
//  chatFrameModel.h
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ChatModel;

@interface ChatFrameModel : NSObject

@property (nonatomic,assign)CGRect timeLabelFrame;

@property (nonatomic,assign)CGRect iconFrame;

@property (nonatomic,assign)CGRect textFrame;

@property (nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,strong)ChatModel *chatModel;

@end
