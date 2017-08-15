//
//  AppDelegate.m
//  RideHailingApp
//
//  Created by AV Dev on 24/07/2017.
//  Copyright © 2017 AV Dev. All rights reserved.
//

#import "AppDelegate.h"
#import "MyViewController.h"
#import "LoginViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
        [Fabric with:@[[Crashlytics class]]];
    
    //sample google api
    [GMSPlacesClient provideAPIKey:@"AIzaSyD1p1aWoNHEgwp4tM4_bJV-HKTpFOLRrnw"];
    
    [GMSServices provideAPIKey:@"AIzaSyD1p1aWoNHEgwp4tM4_bJV-HKTpFOLRrnw"];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    
     window.backgroundColor = [UIColor whiteColor];
    
    window.rootViewController = [LoginViewController new];
    
    
    
    
    
//    [window setRootViewController:viewController];
    
    [window makeKeyAndVisible];
    
    [self setWindow:window];

    
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    self.window.backgroundColor = [UIColor blackColor];
//    
//    [self.window makeKeyAndVisible];
    

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
