//
//  AppDelegate.m
//  iOSExample
//
//  Created by Frank Schmitt on 7/28/16.
//  Copyright © 2016 Apptentive. All rights reserved.
//

#import "AppDelegate.h"
#import "mParticle.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[MParticle sharedInstance].logLevel = MPILogLevelVerbose;

	MParticleOptions *options = [MParticleOptions optionsWithKey:@"<#Your mParticle Key#>" secret:@"<#Your mParticle Secret#>"];
	[[MParticle sharedInstance] startWithOptions:options];

	return YES;
}

@end
