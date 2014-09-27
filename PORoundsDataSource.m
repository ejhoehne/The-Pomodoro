//
//  PORoundsDataSource.m
//  The Pomodoro
//
//  Created by Emily Hoehne on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsDataSource.h"

static NSString * const CurrentRoundKey= @"CurrentRound";

@implementation PORoundsDataSource

- (id)init {
    if (self = [super init] ) {
        self.currentRound = [[NSUserDefaults standardUserDefaults] integerForKey:CurrentRoundKey];
     
    }
       return self;
}
- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self times] count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentRound = indexPath.row;
    [self postMinutes];
}
    
    
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   UITableViewCell *cell = [UITableViewCell dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Round %ld - %@min", indexPath.row + 1, [[[self times] objectAtIndex: indexPath.row] stringValue]];
    return cell;
}
- (NSNumber *)roundAtIndex:(NSInteger)index {
    return [self times][index];
}
- (NSArray *)times {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}
- (void)postMinutes {
    [[NSNotificationCenter defaultCenter]postNotificationName: RoundCompleteNotification object:self];
    
    
}
- (void)endRound: (NSNotification *)notification {
    self.currentRound++;
    if (self.currentRound == [[self times] count]) {
        self.currentRound = 0;
    }
    [self selectCurrentRound];
    [self postMinutes];
}
- (void)setCurrentRound:(NSInteger)currentRound {
    if (currentRound >= [[self times] count] ) {
        self.currentRound = 0;
    } else {
        self.currentRound = currentRound;
    }
    [[NSUserDefaults standardUserDefaults] setValue:@(currentRound) forKey:CurrentRoundKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) selectCurrentRound {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentRound inSection:0];
}


@end
