
//
//  FBNewReminderViewController.m
//  FBReminder
//
//  Created by Xiang Li on 5/20/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderViewController.h"
#import "FBNewReminderTitleTableViewCell.h"
#import <ACEExpandableTextCell/ACEExpandableTextCell.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <Masonry/Masonry.h>

@interface FBNewReminderViewController () <UITableViewDataSource, UITableViewDelegate, ACEExpandableTableViewDelegate>

@property (nonatomic) UITableView *tableView;

// form data
@property (nonatomic) NSString *titleText;

@end

@implementation FBNewReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Delegate -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([FBNewReminderTitleTableViewCell class]) configuration:^(id cell) {
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBNewReminderTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FBNewReminderTitleTableViewCell class]) forIndexPath:indexPath];
    cell.expandableCell.text = self.title;
    cell.expandableCell.expandableTableView = self.tableView;
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark - ACEExpandableTableViewDelegate
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Private -
#pragma mark - Event Handler
- (void)submitButtonTapped:(UIButton *)submitButton
{
    
}

#pragma mark - Setters & Getters -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"Create" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 50, 50);
        button.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, 30);
        [button addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _tableView.tableFooterView = button;
        
        [_tableView registerClass:[FBNewReminderTitleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FBNewReminderTitleTableViewCell class])];
    }
    return _tableView;
}

@end
