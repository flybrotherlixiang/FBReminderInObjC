//
//  FBNewReminderForm.h
//  FBReminder
//
//  Created by Xiang Li on 5/28/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FBNewReminderFormDelegate <NSObject>

- (void)updateTableViewHeight;
- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface FBNewReminderForm : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIViewController<FBNewReminderFormDelegate> *vc;
@property (nonatomic, readonly) NSString *titleText;
@property (nonatomic, readonly) NSDate *date;

@property (nonatomic, readonly) NSArray<NSArray *> *sections;

- (void)registerCellClassForTableView:(UITableView *)tableView;
//- (Class)cellClassFromIndexPath:(NSIndexPath *)indexPath;
//- (void)configCellAtIndexPath:(NSIndexPath *)indexPath;

@end
