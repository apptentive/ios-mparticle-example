//
//  ViewController.m
//  iOSExample
//
//  Created by Frank Schmitt on 7/28/16.
//  Copyright © 2016 Apptentive. All rights reserved.
//

#import "ViewController.h"
#import "ApptentiveKit-Swift.h"
#import "mParticle.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableViewCell *messageCenterCell;

@end

@implementation ViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		[[MParticle sharedInstance] logEvent:[[MPEvent alloc] initWithName:@"survey_event" type:MPEventTypeOther]];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	} else {
		Apptentive *apptentive = [[MParticle sharedInstance] kitInstance:@(MPKitInstanceApptentive)];
		if (apptentive) {
			[apptentive presentMessageCenterFromViewController:self];
		}
	}
}

@end
