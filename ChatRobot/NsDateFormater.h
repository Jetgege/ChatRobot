//
//  NsDateFormater.h
//  ChatRobot
//
//  Created by Jet on 16/6/22.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NsDateFormater : NSDate
+(NSDate*)createDate:(NSString*)timeStr andFormatter:(NSString*)formatterStr;
-(NSString*)descriptionStr;
@end
