//
//  chatFrameModel.m
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "chatFrameModel.h"
#import "ChatModel.h"
//获取手机屏幕的尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
//调节间距使用
#define kDeltaMargin 40


@implementation ChatFrameModel

-(void)setChatModel:(ChatModel *)chatModel{

    _chatModel=chatModel;
    
    //计算frame
    //计算时间Label的frame
    CGFloat timeLabelX=0;
    CGFloat timeLabelY=0;
    CGFloat timeLabelWidth=kScreenSize.width;
    CGFloat timeLabelHeight=15;
    
    _timeLabelFrame=CGRectMake(timeLabelX, timeLabelY, timeLabelWidth, timeLabelHeight);
    
    //计算头像的frame
    CGFloat margin=10;
    CGFloat iconX=margin;
    CGFloat iconY=CGRectGetMaxY(_timeLabelFrame)+margin;
    CGFloat iconWidth=40;
    CGFloat iconHeight=40;
    
    if (chatModel.type == ChatUserTypeMe) {
        
        CGFloat rightIconX=kScreenSize.width-margin-iconWidth;
        _iconFrame=CGRectMake(rightIconX, iconY, iconWidth, iconHeight);
    }else{
        
        _iconFrame=CGRectMake(iconX, iconY, iconWidth, iconHeight);
    }
    
    //计算文本的frame
    CGFloat maxWidth=kScreenSize.width-2*iconWidth-2*margin-kDeltaMargin;
    CGSize maxSize=CGSizeMake(maxWidth, MAXFLOAT);

    CGSize textRealSize=[chatModel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    CGFloat textX=CGRectGetMaxX(_iconFrame)+margin;
    CGFloat textY=iconY;
    
    if (chatModel.type==ChatUserTypeMe) {
        
        CGFloat rightTextX=kScreenSize.width-textRealSize.width-margin-iconWidth-kDeltaMargin-margin;
        
        _textFrame=CGRectMake(rightTextX, textY, textRealSize.width+kDeltaMargin, textRealSize.height+kDeltaMargin);
        
    }else{
        
        _textFrame=CGRectMake(textX, textY, textRealSize.width+kDeltaMargin, textRealSize.height+kDeltaMargin);
    }
    
    //确定cell的高度
    if (CGRectGetMaxY(_textFrame)>CGRectGetMaxY(_iconFrame)) {
        
        //_cellHeight=CGRectGetMaxY(_textFrame)+margin;
        _cellHeight=CGRectGetMaxY(_textFrame);
        
    }else{
        _cellHeight=CGRectGetMaxY(_iconFrame);

//        _cellHeight=CGRectGetMaxY(_iconFrame)+margin;
    }

}
@end
