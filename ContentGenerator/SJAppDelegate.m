//
//  SJAppDelegate.m
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJAppDelegate.h"

#import "SJDemo.h"

@implementation SJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"Number String");
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%@",[SJDemo numberWithLength:[SJDemo next] % 100]);
    }
    
    NSLog(@"Hundred Year Date: %@",[NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*99]);
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%@",[SJDemo dateSinceYear:2004]);
    }
    
    NSLog(@"Boolean");
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%d",[SJDemo boolean]);
    }
    
    NSLog(@"Regions");
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%@",[[SJRegion region] full]);
    }
    
    NSLog(@"Locations");
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%@",[[SJLocation location] full]);
    }
    
    NSLog(@"Phones");
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%@",[[SJPhone phone] full]);
    }
    
    NSLog(@"Persons");
    
    for (int i = 0; i < 10; i ++) {
        NSLog(@"\t%@",[[SJPerson person] full]);
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
