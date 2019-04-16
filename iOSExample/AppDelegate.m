//
//  AppDelegate.m
//  iOSExample
//
//  Created by Frank Schmitt on 7/28/16.
//  Copyright © 2016 Apptentive. All rights reserved.
//

#import "AppDelegate.h"
@import mParticle_Apple_SDK;
//@import mParticle_Apptentive;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[MParticle sharedInstance].logLevel = MPILogLevelVerbose;

	MParticleOptions *options = [MParticleOptions optionsWithKey:@"c0d00506599fd3498f6d74e2a6bd6784" secret:@"IdzrwE0Cd2a65-uzldce-Y3NUu1mKpuXHKt47a5yBCHxez4E7ZtBAlrUvkkGsBzR"];
	[[MParticle sharedInstance] startWithOptions:options];

	return YES;
}

@end
