//
//  DateConvert.m
//  ChatRobot
//
//  Created by Jet on 16/6/22.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "DateConvert.h"

@implementation DateConvert
/**
 生成当前时间对应的字符串
 　  - returns: 对应时间格式
 */
+(NSString*)descriptionStr:(NSDate*)timeD{
    
    //１.创建时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //如果不指定以下代码真机中肯能无法转换,设置时区
    [formatter setLocale: [[NSLocale alloc]initWithLocaleIdentifier:@"zh"]];
    
    //创建一个日历类
    NSCalendar *calendar =[NSCalendar currentCalendar];
    //定义变量记录时间格式
    NSString *formatterStr = @"HH:mm";
    
    if ([calendar isDateInToday:timeD]) {
        //今天
        NSInteger interval = [[NSDate date]timeIntervalSinceDate:timeD];
        if (interval<60) {
            return @"刚刚";
        }else if(interval<(60*60)){
            NSInteger result = interval/60;
            return  [NSString stringWithFormat:@"%ld分钟前",result];
        }else {
            //else if(interval<60*60*24)
            NSInteger result = (interval/(60*60));
            return [NSString stringWithFormat:@"%ld小时前",result];
//            @"\(interval/(60*60))小时前";
            
        }
    }else if ([calendar isDateInYesterday:timeD]){
        
        formatterStr = [NSString stringWithFormat:@"%@%@",@"昨天 ",formatterStr];
        
    }else{
        
        //该方法可以获取两个时间之间的差值  NSCalendarUnit.Year年的差值
        
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:timeD toDate:[NSDate date] options:0];
        if (comps.year>=1){
            //更早时间
            formatterStr = [NSString stringWithFormat:@"%@%@",@"yyyy-MM-dd ",formatterStr];
            
        }else{
            //一年以内
            formatterStr = [NSString stringWithFormat:@"%@%@",@"MM-dd ",formatterStr];
        }
    }
    formatter.dateFormat = formatterStr;
    return [formatter stringFromDate:timeD];
    
}

@end
