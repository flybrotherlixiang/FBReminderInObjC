//
//  FBNewReminderTitleTableViewCell.m
//  FBReminder
//
//  Created by Xiang Li on 5/21/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderTitleTableViewCell.h"
#import <Masonry/Masonry.h>

@interface FBNewReminderTitleTableViewCell () <UITextViewDelegate>

@property (nonatomic) UITextView *textView;
@property (nonatomic) MASConstraint *heightConstraint;

@end

@implementation FBNewReminderTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.contentView);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            self.heightConstraint = make.height.equalTo(@0);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Delegate -
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    [self updateSize];
    
    if ([self.delegate respondsToSelector:@selector(titleTableViewCell:textViewDidChange:)]) {
        [self.delegate titleTableViewCell:self textViewDidChange:self.textView];
    }
}

#pragma mark - Private -
- (void)updateSize
{
#warning TODO:
    CGSize newSize = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGFLOAT_MAX)];
    self.heightConstraint.offset = newSize.height;
}

#pragma mark - Getters & Setters -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.text = @"标题";
    }
    return _titleLabel;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
    }
    return _textView;
}

- (NSString *)text
{
    return _textView.text;
}

- (void)setText:(NSString *)text
{
    _textView.text = text;
    [self updateSize];
}

@end
