//
//  FBNewReminderTitleTableViewCell.h
//  FBReminder
//
//  Created by Xiang Li on 5/21/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBNewReminderTitleTableViewCell;

@protocol FBNewReminderTitleTableViewCellDelegate <NSObject>

- (void)titleTableViewCell:(FBNewReminderTitleTableViewCell *)cell textViewDidChange:(UITextView *)textView;

@end

@interface FBNewReminderTitleTableViewCell : UITableViewCell

@property (nonatomic) NSString *text;
@property (nonatomic) UILabel *titleLabel;

@property (nonatomic, weak) id<FBNewReminderTitleTableViewCellDelegate> delegate;
@property (nonatomic) NSIndexPath *indexPath;

@end
