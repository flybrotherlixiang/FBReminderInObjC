
//
//  FBNewReminderViewController.m
//  FBReminder
//
//  Created by Xiang Li on 5/20/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderViewController.h"
#import "FBNewReminderTitleTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <Masonry/Masonry.h>

@interface FBNewReminderViewController () <UITableViewDataSource, UITableViewDelegate, FBNewReminderTitleTableViewCellDelegate>

@property (nonatomic) UITableView *tableView;

// form data
@property (nonatomic) NSString *titleText;

@end

@implementation FBNewReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleText = @"五点啦要吃药啦";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    CGFloat height =  [tableView fd_heightForCellWithIdentifier:NSStringFromClass([FBNewReminderTitleTableViewCell class]) configuration:^(id cell) {
        FBNewReminderTitleTableViewCell *aCell = (FBNewReminderTitleTableViewCell *)cell;
        aCell.text = self.titleText;
    }];

    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBNewReminderTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FBNewReminderTitleTableViewCell class]) forIndexPath:indexPath];
    cell.placeholderText = @"Title";
    cell.delegate = self;
    cell.text = self.titleText;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark - ACEExpandableTableViewDelegate
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - FBNewReminderTitleTableViewCellDelegate
- (void)titleTableViewCell:(FBNewReminderTitleTableViewCell *)cell textViewDidChange:(UITextView *)textView
{
    self.titleText = textView.text;
    NSIndexPath *indexPath = cell.indexPath;
    if (indexPath) {
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [_tableView registerClass:[FBNewReminderTitleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FBNewReminderTitleTableViewCell class])];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.tableFooterView = [self footerView];
    }
    return _tableView;
}

- (UIView *)footerView
{
    UIView *footerContainerView = [[UIView alloc] init];
    footerContainerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100);
    footerContainerView.backgroundColor = [UIColor greenColor];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"Create" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 3;
    button.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, 30);
    [button addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footerContainerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footerContainerView);
        make.width.equalTo(footerContainerView).offset(-40).priority(MASLayoutPriorityDefaultLow);
        make.height.equalTo(@50);
    }];
    
    return footerContainerView;
}

@end
