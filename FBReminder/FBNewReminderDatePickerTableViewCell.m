//
//  FBNewReminderDatePickerTableViewCell.m
//  FBReminder
//
//  Created by Xiang Li on 5/28/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderDatePickerTableViewCell.h"
#import <Masonry/Masonry.h>
#import "FBReminderConstants.h"

@implementation FBNewReminderDatePickerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 6, 8, 6));
        }];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Getters -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kFBReminderCommonFontSize];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

@end
