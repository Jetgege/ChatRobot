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
    [AVOSCloud setApplicationId:@"y5r75BzqWXtYSQScpi08W2MX-gzGzoHsz"
                      clientKey:@"vFhJExqUbTphogNm7KRHg3CI"];
    
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application{

    [[UIApplication　sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil];
}

@end
