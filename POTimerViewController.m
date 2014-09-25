//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Emily Hoehne on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "PORoundsDataSource.h"
#import "PORoundsViewController.h"
#import "POTimer.h"

@interface POTimerViewController ()

@property (nonatomic, assign) BOOL active;

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;

@end

@implementation POTimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self registerForNotifications];
    }
    return self;
}
- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound:) name:NewRoundTimeNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateButton) name:TimerCompleteNotification object:nil];
}

- (void) unregisterForNotifications {
    [self unregisterForNotifications];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Focus";
    [self updateLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonDisable:(id)sender {
    [[POTimer sharedInstance] startTimer];
    self.button.enabled = NO;
    
}
- (void)newRound:(NSNotification *)notification {
    [self updateLabel];
    [self updateButton];
}
- (void) updateLabel {
    if ([POTimer sharedInstance].seconds < 10) {
        self.label.text = [NSString stringWithFormat:@"%ld:0%ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    } else {
        self.label.text = [NSString stringWithFormat:@"%ld:%ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    }
}
- (void)updateButton {
    self.button.enabled = YES;
}



@end
