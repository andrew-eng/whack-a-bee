//
//  LevelTableViewController.m
//  whack-a-bee
//
//  Created by Andrew Eng on 24/5/14.
//  Copyright (c) 2014 Andrew Eng. All rights reserved.
//

#import "LevelTableViewController.h"
#import "GameViewController.h"

@interface LevelTableViewController ()

@end

@implementation LevelTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"game"]) {
        GameViewController *controller = segue.destinationViewController;
        controller.username = self.username;
    }
}

@end
