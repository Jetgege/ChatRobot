//
//  AppDelegate.m
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "AppDelegate.h"
#import "CloudData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置LeanClouud
    [AVOSCloud setApplicationId:@"0AbaiEKM9mE8tAy8BCaBsCy0-gzGzoHsz"
                      clientKey:@"qcPCgCKJ3SxR9Ig6brhfMHCb"];
    
    return YES;
}


@end
