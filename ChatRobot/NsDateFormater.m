//
//  NsDateFormater.m
//  ChatRobot
//
//  Created by Jet on 16/6/22.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "NsDateFormater.h"

@implementation NsDateFormater
/**
 根据根式字符串返回一个
 - parameter timeStr:      字符串格式时间
 - parameter formatterStr: 字符串时间对应的格式
 - returns: NSDate
 */
+(NSDate*)createDate:(NSString*)timeStr andFormatter:(NSString*)formatterStr{
    
    // timeStr = "Sat May 13 11:31:11 +0800 2015"
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat =  formatterStr;
    //如果不指定以下代码真机中肯能无法转换,设置时区
   
    [formatter setLocale: [[NSLocale alloc]initWithLocaleIdentifier:@"en"]];
    //返回NSDate

    return  [formatter dateFromString:timeStr];
}

/**
 生成当前时间对应的字符串
 　  - returns: 对应时间格式
 */
-(NSString*)descriptionStr{
    
    //１.创建时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    //如果不指定以下代码真机中肯能无法转换,设置时区
    [formatter setLocale: [[NSLocale alloc]initWithLocaleIdentifier:@"en"]];
    
    //创建一个日历类
    NSCalendar *calendar =[NSCalendar currentCalendar];
    //定义变量记录时间格式
    NSString *formatterStr = @"HH:mm";
    
    if ([calendar isDateInToday:self]) {
        //今天
        NSInteger interval = [[NSDate date]timeIntervalSinceDate:self];
        if (interval<60) {
            return @"刚刚";
        }else if(interval<(60*60)){
            
            return  @"\(interval/60)分钟前";
        }else {
            //else if(interval<60*60*24)
            return  @"\(interval/(60*60))小时前";
            
        }
    }else if ([calendar isDateInYesterday:self]){
        
        formatterStr = [NSString stringWithFormat:@"%@%@",@"昨天 ",formatterStr];
        
    }else{
        
        //该方法可以获取两个时间之间的差值  NSCalendarUnit.Year年的差值
        
      NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:0];
        if (comps.year>=1){
            //更早时间
            formatterStr = [NSString stringWithFormat:@"%@%@",@"yyyy-MM-dd ",formatterStr];

        }else{
            //一年以内
            formatterStr = [NSString stringWithFormat:@"%@%@",@"MM-dd ",formatterStr];
        }
    }
    formatter.dateFormat = formatterStr;
    return [formatter stringFromDate:self];
    
}

@end
