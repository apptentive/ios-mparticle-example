//
//  AppDelegate.m
//  iOSExample
//
//  Created by Frank Schmitt on 7/28/16.
//  Copyright © 2016 Apptentive. All rights reserved.
//

#import "AppDelegate.h"
#import "mParticle.h"
#import "ApptentiveKit-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[MParticle sharedInstance].logLevel = MPILogLevelVerbose;

    Apptentive.shared.logLevel = ApptentiveLogLevelDebug;

	MParticleOptions *options = [MParticleOptions optionsWithKey:@"c0d00506599fd3498f6d74e2a6bd6784" secret:@"IdzrwE0Cd2a65-uzldce-Y3NUu1mKpuXHKt47a5yBCHxez4E7ZtBAlrUvkkGsBzR"];
    options.logLevel = MPILogLevelVerbose;
	[[MParticle sharedInstance] startWithOptions:options];


    [application registerForRemoteNotifications];

    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"Got permission!");
        } else {
            NSLog(@"No sounds or alerts for you! (%@)", error);
        }
    }];

	return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[MParticle sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[MParticle sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    [[MParticle sharedInstance] didReceiveRemoteNotification:userInfo];

    completionHandler(UIBackgroundFetchResultNewData);
}

@end
