//
//  POAppSettings.m
//  The Pomodoro
//
//  Created by Emily Hoehne on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAppSettings.h"

@implementation POAppSettings

+ (POAppSettings *)sharedInstance {
    static POAppSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[POAppSettings alloc] init];
        [sharedInstance registerForCompleteNotifications];
    });
    return sharedInstance;
}

- (void)registerForCompleteNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToRoundCompleteNotification) name:@"RoundCompleteNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToTimerCompleteNotification) name:@"RoundCompleteNotification" object:nil];
}

- (void) unregisterForRoundCompleteNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RoundCompleteNotifications" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TimerCompleteNotifications" object:nil];
}
- (void) respondToRoundCompleteNotification {
    NSLog(@"RoundCompleteNotification");
}

- (void) respondToTimerCompleteNotification {
    NSLog(@"TimerCompleteNotification");

}

@end
