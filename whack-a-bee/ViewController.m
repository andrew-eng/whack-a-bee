//
//  ViewController.m
//  whack-a-bee
//
//  Created by Andrew Eng on 23/5/14.
//  Copyright (c) 2014 Andrew Eng. All rights reserved.
//

#import "ViewController.h"
#import "LevelTableViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Dismiss keyboard
    [textField resignFirstResponder];
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"levelSelect"]) {
        
        // Set the username in LevelTableViewController
        LevelTableViewController *controller = segue.destinationViewController;
        controller.username = self.textField.text;
    }
}


@end
