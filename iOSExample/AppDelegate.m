//
//  AppDelegate.m
//  iOSExample
//
//  Created by Frank Schmitt on 7/28/16.
//  Copyright © 2016 Apptentive. All rights reserved.
//

#import "AppDelegate.h"
@import ApptentiveKit;
@import mParticle_Apple_SDK_ObjC;
@import UserNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MParticleOptions *options = [MParticleOptions optionsWithKey:@"<#Your mParticle Key#>" secret:@"<#Your mParticle Secret#>"];
    options.logLevel = MPILogLevelVerbose;
    [[MParticle sharedInstance] startWithOptions:options];

    // mParticle 9 no longer intercepts app delegate calls, so push events are forwarded explicitly below.
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound)
                                                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [application registerForRemoteNotifications];
            });
        }
    }];

    return YES;
}

#pragma mark - Push notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[MParticle sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[MParticle sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // The kit passes Apptentive an empty completion handler, so Apptentive pushes go to Apptentive directly:
    // it calls completionHandler only after new messages are downloaded.
    if ([Apptentive.shared didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler]) {
        return;
    }

    [[MParticle sharedInstance] didReceiveRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[MParticle sharedInstance] userNotificationCenter:center willPresentNotification:notification];

    // The kit doesn't forward this call. Apptentive hides its own pushes in the foreground,
    // because it shows a local notification for new messages instead.
    if ([Apptentive.shared willPresent:notification withCompletionHandler:completionHandler]) {
        return;
    }

    completionHandler(UNNotificationPresentationOptionBanner | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [[MParticle sharedInstance] userNotificationCenter:center didReceiveNotificationResponse:response];
    completionHandler();
}

@end
