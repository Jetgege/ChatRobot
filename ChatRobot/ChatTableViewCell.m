//
//  ChatTableViewCell.m
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "ChatFrameModel.h"
#import "ChatModel.h"
#import "DateConvert.h"
#import "UIButton+btnCate.h"

@interface ChatTableViewCell()

@property(nonatomic,weak)UILabel *timeLabel;

@property(nonatomic,weak)UIImageView *userIcon;

@property(nonatomic,weak)UIButton *contentButton;

@end
NSString *lastStr = nil;

@implementation ChatTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark-
#pragma mark-重写frameModel的set方法
-(void)setChatFrameModel:(ChatFrameModel *)chatFrameModel{
    _chatFrameModel=chatFrameModel;
    
    [self setupData];
    
    [self setupFrame];
}

#pragma mark-
#pragma mark-添加子控件setupUI
-(void)setupUI{
    //1时间
    UILabel *timeLabel=[[UILabel alloc]init];
    _timeLabel=timeLabel;
    
    timeLabel.textAlignment=NSTextAlignmentCenter;//居中显示
    [self.contentView addSubview:timeLabel];
    
    //2.头像
    UIImageView *userIcon=[[UIImageView alloc]init];
    _userIcon=userIcon;
    
    [self.contentView addSubview:userIcon];
    
    //3.文本Button
    UIButton *contentButton=[[UIButton alloc]init];
    _contentButton=contentButton;
    [contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    contentButton.titleLabel.numberOfLines=0;
    contentButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [_contentButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    //设置内边距
    contentButton.contentEdgeInsets=UIEdgeInsetsMake(20, 20, 20, 20);
    
    [self.contentView addSubview:contentButton];
}

//给聊天文本添加点击事件
-(void)clickButton:(UIButton*)btn{
    NSString *url = btn.urlTag;
    if (url.length!=0) {
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:url,@"urlBtn",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SafariOpenUrl" object:nil userInfo:dict];
    }
}

#pragma mark-
#pragma mark-为子控件设置frame
-(void)setupFrame{
    
    //时间frame
    _timeLabel.frame=_chatFrameModel.timeLabelFrame;
    
    //用户头像frame
    _userIcon.frame=_chatFrameModel.iconFrame;
    
    //文本frame
    _contentButton.frame=_chatFrameModel.textFrame;
}

#pragma mark-
#pragma mark-设置数据
-(void)setupData{
    
    ChatModel *chatModel=_chatFrameModel.chatModel;

    NSString *timeStr = [DateConvert descriptionStr:chatModel.dateTimes];
    _timeLabel.text = timeStr;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    //显示时间的处理
     _timeLabel.hidden = chatModel.hidenTimeLabel;
    if ([lastStr isEqualToString:timeStr]) {
        _timeLabel.hidden = true;
    }
   lastStr = timeStr;
    //2.设置头像
    
    if (chatModel.type==ChatUserTypeMe) {//表示自己
        _userIcon.image=[UIImage imageNamed:@"me"];
        
        UIImage *resizeImage=[self resizeImage:@"chat_send_nor"];
        [_contentButton setBackgroundImage: resizeImage forState:UIControlStateNormal];
        
    }else{
        
        _userIcon.image=[UIImage imageNamed:@"other"];
        UIImage *resizeImage=[self resizeImage:@"chat_recive_press_pic"];
        
        [_contentButton setBackgroundImage: resizeImage forState:UIControlStateNormal];
    }
    
    [_contentButton setUrlTag:nil];
    if (chatModel.url.length != 0) {
        NSLog(@"%@",chatModel.url);
        [_contentButton setUrlTag:chatModel.url];
    }
  
    [_contentButton setTitle:chatModel.text forState:UIControlStateNormal];

}



#pragma mark-
#pragma mark-把图片针对某一点进行拉伸
-(UIImage*)resizeImage:(NSString*)imageName{
    
    //原图片
    UIImage *image=[UIImage imageNamed:imageName];
    
    //计算拉伸的点（或者拉伸的区域）
    CGFloat halfWidth=image.size.width/2;
    CGFloat halfHeight=image.size.height/2;
    
    UIEdgeInsets edgeInstes=UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth);
    
    //拉伸后的图片
    UIImage *resizeImage=[image resizableImageWithCapInsets:edgeInstes resizingMode:UIImageResizingModeStretch];
    return resizeImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
