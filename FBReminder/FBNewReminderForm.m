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
#import <PDTSimpleCalendar/PDTSimpleCalendar.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface FBNewReminderForm () <FBNewReminderTitleTableViewCellDelegate>

@property (nonatomic) NSArray<NSArray *> *sections;

@property (nonatomic) NSString *titleText;
@property (nonatomic) NSDate *date;

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
        dateCell.titleLabel.text = [formatter stringFromDate:[NSDate date]];
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
        PDTSimpleCalendarViewController *vc = [[PDTSimpleCalendarViewController alloc] init];
        [self.vc.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - FBNewReminderTitleTableViewCellDelegate
- (void)titleTableViewCell:(FBNewReminderTitleTableViewCell *)cell textViewDidChange:(UITextView *)textView
{
    self.titleText = textView.text;
    [self.vc updateTableViewHeight];
}

@end
