//
//  FBNewReminderDatePickerViewController.m
//  FBReminder
//
//  Created by Xiang Li on 5/29/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderDatePickerViewController.h"
#import "FBPresentNavigationView.h"
#import <PDTSimpleCalendar/PDTSimpleCalendar.h>
#import <Masonry/Masonry.h>

@interface FBNewReminderDatePickerViewController () <FBPresentNavigationViewDelegate>

@property (nonatomic) FBPresentNavigationView *navigationView;

@end

@implementation FBNewReminderDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.calendarVC.view];
    [self addChildViewController:self.calendarVC];
    [self.view addSubview:self.navigationView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@44);
    }];
    
    [self.calendarVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationView);
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.calendarVC.view.frame = CGRectMake(0, CGRectGetHeight(self.navigationView.frame), CGRectGetWidth(self.navigationView.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navigationView.frame));
}

#pragma mark - Delegate -
#pragma mark - FBPresentNavigationViewDelegate
- (void)goBackButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getters -
- (PDTSimpleCalendarViewController *)calendarVC
{
    if (!_calendarVC) {
        _calendarVC = [[PDTSimpleCalendarViewController alloc] init];
    }
    return _calendarVC;
}

- (FBPresentNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [[FBPresentNavigationView alloc] init];
        _navigationView.delegate = self;
    }
    return _navigationView;
}

@end
