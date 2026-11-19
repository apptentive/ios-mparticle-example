//
//  ViewController.m
//  iOSExample
//
//  Created by Frank Schmitt on 7/28/16.
//  Copyright © 2016 Apptentive. All rights reserved.
//

#import "ViewController.h"
@import ApptentiveKit;
@import mParticle_Apple_SDK_ObjC;

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableViewCell *messageCenterCell;

@end

@implementation ViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        [[MParticle sharedInstance] logEvent:[[MPEvent alloc] initWithName:@"survey_event" type:MPEventTypeOther]];
    } else {
        // The synchronous call returns nil while the kit isn't active. The async variant would queue
        // the handler and run it later, so taps would pile up.
        Apptentive *apptentive = [[MParticle sharedInstance] kitInstance:@(MPKitInstanceApptentive)];
        if (!apptentive) {
            NSLog(@"Apptentive kit is not active yet. Check the mParticle key and the Apptentive connection.");
            return;
        }
        [apptentive presentMessageCenterFromViewController:self];
    }
}

@end
