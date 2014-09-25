//
//  PORoundsViewController.m
//  The Pomodoro
//
//  Created by Emily Hoehne on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsViewController.h"
#import "POTimerViewController.h"
#import "PORoundsDataSource.h"
#import "POTimer.h"

@interface PORoundsViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PORoundsDataSource  *dataSource;

@end

@implementation PORoundsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotifications];
    }
    return self;
}
- (void) registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRound:) name:TimerCompleteNotification object:nil];
}
- (void) unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TimerCompleteNotification object:nil];
}
- (void)dealloc {
    [self unregisterForNotifications];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Rounds";
    self.tableView = [UITableView new];
    [self.view addSubview: self.tableView];
    self.dataSource = [PORoundsDataSource new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    
    [self.tableView registerClass:[UITableView class] forCellReuseIdentifier:@"cell"];
    [self selectCurrentRound];
    [self updateTimer];
    
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    self.dataSource.currentRound = indexPath.row;
    [self updateTimer];
}
- (void) updateTimer {
    [[POTimer sharedInstance] cancelTimer];
    [POTimer sharedInstance].minutes = [[self.dataSource roundAtIndex:self.dataSource.currentRound]integerValue];
    [POTimer sharedInstance].seconds = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundTimeNotificationName object:nil userInfo:nil];
}
- (void) endRound:(NSNotification *)notification{
    self.dataSource.currentRound++;
    
    [self selectCurrentRound];
    [self updateTimer];
    
}
- (void) selectCurrentRound {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataSource.currentRound inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
