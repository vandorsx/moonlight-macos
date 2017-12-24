//
//  AppsViewController.h
//  Moonlight for macOS
//
//  Created by Michael Kenny on 23/12/17.
//  Copyright © 2017 Moonlight Stream. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TemporaryHost.h"
#import "HostsViewController.h"

@interface AppsViewController : NSViewController
@property (nonatomic, strong) TemporaryHost *host;
@property (nonatomic, strong) HostsViewController *hostsVC;
@end