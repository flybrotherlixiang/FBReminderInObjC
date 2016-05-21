//
//  FBMainViewController.m
//  FBReminder
//
//  Created by Xiang Li on 5/20/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBMainViewController.h"
#import "FBNewReminderViewController.h"

@interface FBMainViewController ()

@end

@implementation FBMainViewController

#pragma mark - Life Cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self addNewReminderButton];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"create"];
    
}

#pragma mark - Private -
- (void)addNewReminderButton
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewReminderButton"]];
    imageView.bounds = CGRectMake(0, 0, 21, 21);
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCreateNewReminder:)];
    [imageView addGestureRecognizer:tap];
    UIBarButtonItem *addMoreButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    self.navigationItem.rightBarButtonItem = addMoreButton;
}

- (void)goCreateNewReminder
{
    FBNewReminderViewController *vc = [[FBNewReminderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters & Setters -

@end
