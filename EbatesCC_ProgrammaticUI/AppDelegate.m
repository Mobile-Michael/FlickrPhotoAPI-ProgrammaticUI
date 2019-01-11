//
//  AppDelegate.m
//  EbatesCC_StoryBoard
//
//  Created by Mike Mullin on 1/9/19.
//  Copyright © 2019 EbatesInterview. All rights reserved.
//

#import "AppDelegate.h"
#import "Controllers/FlickrTableViewController.h"
#import "Model/Reachability.h"

@interface AppDelegate () <UISplitViewControllerDelegate>
@property(nonatomic, strong) UIWindow *mainWindow;
@end

@implementation AppDelegate
@synthesize  mainWindow;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    FlickrTableViewController *startController = [[FlickrTableViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:startController];
    startController.view.backgroundColor = [UIColor blackColor];
    
    
    self.mainWindow = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    self.mainWindow.rootViewController = navigationController;
    [self.mainWindow makeKeyAndVisible];
    
    
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


@end
