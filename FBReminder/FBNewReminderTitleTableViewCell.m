//
//  FBNewReminderTitleTableViewCell.m
//  FBReminder
//
//  Created by Xiang Li on 5/21/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderTitleTableViewCell.h"
#import <ACEExpandableTextCell/ACEExpandableTextCell.h>

@implementation FBNewReminderTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.expandableCell];
    }
    return self;
}

- (ACEExpandableTextCell *)expandableCell
{
    if (!_expandableCell) {
        _expandableCell = [[ACEExpandableTextCell alloc] init];
    }
    return _expandableCell;
}

@end
