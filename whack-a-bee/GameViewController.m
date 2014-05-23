//
//  GameViewController.m
//  whack-a-bee
//
//  Created by Andrew Eng on 24/5/14.
//  Copyright (c) 2014 Andrew Eng. All rights reserved.
//

#import "GameViewController.h"
#import "ScoreViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface GameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) int score;
@property (nonatomic) float time;

@property (nonatomic, strong) AVAudioPlayer *backgroundPlayer;
@property (nonatomic, strong) AVAudioPlayer *hitPlayer;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.time = 20;
    
    // Hide all buttons initially.
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        button.hidden = YES;
    }
    
    // Repeatly show a random button
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(showRandomButton)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.navigationItem.hidesBackButton = YES;
    

    // Get melody URL
    NSString *melodyFilePath = [[NSBundle mainBundle] pathForResource:@"melody" ofType:@"mp3"];
    NSURL *melodyFileURL = [NSURL fileURLWithPath:melodyFilePath];
    
    // Setup player to play melody
    self.backgroundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:melodyFileURL error:nil];
    self.backgroundPlayer.numberOfLoops = -1; // Loop forever
    [self.backgroundPlayer prepareToPlay];
    
    
    // Get bomb URL
    NSString *bombFilePath = [[NSBundle mainBundle] pathForResource:@"bomb" ofType:@"mp3"];
    NSURL *bombFileURL = [NSURL fileURLWithPath:bombFilePath];

    // Setup player to play bomb sound
    self.hitPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bombFileURL error:nil];
    self.hitPlayer.numberOfLoops = 0;
    [self.hitPlayer prepareToPlay];
    
    
    [self.backgroundPlayer play];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Stop timer when view disappears
    [self.timer invalidate];
    self.timer = nil;
    
    [self.backgroundPlayer stop];
}

- (void)showRandomButton
{
    // Get a random button in buttons array
    int randomIndex = arc4random() % self.buttons.count;
    UIButton *button = self.buttons[randomIndex];
    
    
    if (button.hidden) {
        button.hidden = NO;
        
        // Hide button after some delay
        [self performSelector:@selector(hideButton:) withObject:button afterDelay:0.5];
    }
    
    // Update time
    self.time -= 0.2;
    self.timerLabel.text = [NSString stringWithFormat:@"Timer: %.1f", self.time];
    
    // Transition to next screen when time ends
    if (fabs(self.time) < 0.001) {
        [self performSegueWithIdentifier:@"score" sender:self];
    }
}

- (void)hideButton:(UIButton *)button
{
    button.hidden = YES;
}

- (IBAction)didTapButton:(id)sender {
    
    // Increment score everytime button is tapped.
    self.score++;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.score];
    
    // Reset hitPlayer before playing sound
    [self.hitPlayer stop];
    self.hitPlayer.currentTime = 0;
    
    [self.hitPlayer play];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"score"]) {
        ScoreViewController *controller = segue.destinationViewController;
        controller.username = self.username;
        controller.score = self.score;
    }
}

@end
