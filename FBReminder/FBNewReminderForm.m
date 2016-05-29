//
//  FBNewReminderForm.m
//  FBReminder
//
//  Created by Xiang Li on 5/28/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderForm.h"
#import "FBNewReminderTitleTableViewCell.h"
#import "FBNewReminderDatePickerTableViewCell.h"
#import "FBNewReminderTimePickerTableViewCell.h"
#import "KPTimePicker.h"
#import "FBNewReminderDatePickerViewController.h"
#import <PDTSimpleCalendar/PDTSimpleCalendar.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface FBNewReminderForm () <FBNewReminderTitleTableViewCellDelegate, PDTSimpleCalendarViewDelegate, KPTimePickerDelegate>

@property (nonatomic) NSArray<NSArray *> *sections;

// title
@property (nonatomic) NSString *titleText;
// date
@property (nonatomic) NSDate *date;
@property (nonatomic) FBNewReminderDatePickerViewController *datePickerVC;
// time
@property (nonatomic) NSDate *time;
@property (nonatomic) KPTimePicker *timePickerView;

@end


@implementation FBNewReminderForm

#pragma mark - Life Cycle -
- (instancetype)init
{
    if (self = [super init]) {
        self.sections = @[
                          @[
                              [FBNewReminderTitleTableViewCell class],
                              ],
                          @[
                              [FBNewReminderDatePickerTableViewCell class]
                              ],
                          @[
                              [FBNewReminderTimePickerTableViewCell class]
                              ]
                          ];
    }
    return self;
}

#pragma mark - Public -
- (void)registerCellClassForTableView:(UITableView *)tableView
{
    [self.sections enumerateObjectsUsingBlock:^(NSArray * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        [section enumerateObjectsUsingBlock:^(Class cellClass, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        }];
    }];
}

- (Class)cellClassFromIndexPath:(NSIndexPath *)indexPath
{
    return self.sections[indexPath.section][indexPath.row];
}

- (void)configCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [cell class];
    if (cellClass == [FBNewReminderTitleTableViewCell class]) {
        FBNewReminderTitleTableViewCell *titleCell = (FBNewReminderTitleTableViewCell *)cell;
        titleCell.placeholderText = @"Title";
        titleCell.delegate = self;
        titleCell.text = self.titleText;
        titleCell.indexPath = indexPath;
    } else if (cellClass == [FBNewReminderDatePickerTableViewCell class]) {
        FBNewReminderDatePickerTableViewCell *dateCell = (FBNewReminderDatePickerTableViewCell *)cell;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *dateToShow = self.date ? : [NSDate date];
        dateCell.titleLabel.text = [formatter stringFromDate:dateToShow];
    } else if (cellClass == [FBNewReminderTimePickerTableViewCell class]) {
        FBNewReminderTimePickerTableViewCell *timeCell = (FBNewReminderTimePickerTableViewCell *)cell;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSDate *dateToShow = self.time ? : [NSDate date];
        timeCell.titleLabel.text = [formatter stringFromDate:dateToShow];
    }
}

#pragma mark - Delegate -
#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClassFromIndexPath:indexPath];
    CGFloat height =  [tableView fd_heightForCellWithIdentifier:NSStringFromClass(cellClass) configuration:^(id cell) {
        [self configCell:cell AtIndexPath:indexPath];
    }];
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClassFromIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
    [self configCell:cell AtIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClassFromIndexPath:indexPath];
    if (cellClass == [FBNewReminderDatePickerTableViewCell class]) {
        [self.vc endEditing];
        [self.vc presentViewController:self.datePickerVC animated:YES completion:nil];
    } else if (cellClass == [FBNewReminderTimePickerTableViewCell class]) {
        [self.vc endEditing];
        [self.vc.view addSubview:self.timePickerView];
    }
}

#pragma mark - FBNewReminderTitleTableViewCellDelegate
- (void)titleTableViewCell:(FBNewReminderTitleTableViewCell *)cell textViewDidChange:(UITextView *)textView
{
    self.titleText = textView.text;
    [self.vc updateTableViewHeight];
}

#pragma mark - PDTSimpleCalendarViewDelegate
- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    self.date = date;
    [self.datePickerVC dismissViewControllerAnimated:YES completion:nil];
    [self.vc reloadCellAtIndexPath:[self indexPathForCellClass:[FBNewReminderDatePickerTableViewCell class]]];
}

#pragma mark - KPTimePickerDelegate
-(void)timePicker:(KPTimePicker*)timePicker selectedDate:(NSDate *)date
{
    self.time = date;
    [self.timePickerView removeFromSuperview];
    [self.vc reloadCellAtIndexPath:[self indexPathForCellClass:[FBNewReminderTimePickerTableViewCell class]]];
}

#pragma mark - Private -
- (NSIndexPath *)indexPathForCellClass:(Class)cellClass
{
    for (int i = 0;i < self.sections.count;i++) {
        NSArray *section = self.sections[i];
        for (int j = 0; j < section.count; j++) {
            if (cellClass == section[j]) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    NSAssert(NO, @"wrong cell class");
    return nil;
}

#pragma mark - Getters -
- (FBNewReminderDatePickerViewController *)datePickerVC
{
    if (!_datePickerVC) {
        _datePickerVC = [[FBNewReminderDatePickerViewController alloc] init];
        _datePickerVC.calendarVC.delegate = self;
    }
    return _datePickerVC;
}

- (KPTimePicker *)timePickerView
{
    if (!_timePickerView) {
        _timePickerView = [[KPTimePicker alloc] init];
        _timePickerView.delegate = self;
    }
    return _timePickerView;
}

@end
