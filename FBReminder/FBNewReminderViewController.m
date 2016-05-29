
//
//  FBNewReminderViewController.m
//  FBReminder
//
//  Created by Xiang Li on 5/20/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderViewController.h"
#import "FBNewReminderForm.h"
#import <Masonry/Masonry.h>

@interface FBNewReminderViewController ()

@property (nonatomic) UITableView *tableView;
@property (nonatomic) FBNewReminderForm *form;

@end

@implementation FBNewReminderViewController

#pragma mark - Life Cycle -
- (void)viewDidLoad {
    [super viewDidLoad];

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
#pragma mark - FBNewReminderFormDelegate
- (void)updateTableViewHeight
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)endEditing
{
    [self.tableView endEditing:YES];
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
        [self.form registerCellClassForTableView:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self.form;
        _tableView.delegate = self.form;
        _tableView.tableFooterView = [self footerView];
    }
    return _tableView;
}

- (FBNewReminderForm *)form
{
    if (!_form) {
        _form = [[FBNewReminderForm alloc] init];
        _form.vc = self;
    }
    return _form;
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
