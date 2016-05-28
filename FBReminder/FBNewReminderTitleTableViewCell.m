//
//  FBNewReminderTitleTableViewCell.m
//  FBReminder
//
//  Created by Xiang Li on 5/21/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBNewReminderTitleTableViewCell.h"
#import <RPFloatingPlaceholders/RPFloatingPlaceholderTextView.h>
#import <Masonry/Masonry.h>

@interface FBNewReminderTitleTableViewCell () <UITextViewDelegate>

@property (nonatomic) RPFloatingPlaceholderTextView *textView;
@property (nonatomic) MASConstraint *heightConstraint;

@end

@implementation FBNewReminderTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textView];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(28, 3, 8, 3));
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
    self.heightConstraint.offset = newSize.height + 30;
}

#pragma mark - Getters & Setters -
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[RPFloatingPlaceholderTextView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)];
        _textView.font = [UIFont systemFontOfSize:18];
        _textView.floatingLabel.font = [UIFont systemFontOfSize:14];
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

- (NSString *)placeholderText
{
    return _textView.placeholder;
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _textView.placeholder = placeholderText;
}

@end
