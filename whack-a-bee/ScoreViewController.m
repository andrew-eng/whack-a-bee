//
//  ScoreViewController.m
//  whack-a-bee
//
//  Created by Andrew Eng on 24/5/14.
//  Copyright (c) 2014 Andrew Eng. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ScoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.username];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.score];
    
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)didTapSubmit:(id)sender
{
    
}

- (IBAction)didTapRestart:(id)sender
{
    
    // Pop all the way to the first page
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
