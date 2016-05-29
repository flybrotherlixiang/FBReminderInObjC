//
//  FBPresentNavigationView.m
//  FBReminder
//
//  Created by Xiang Li on 5/29/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBPresentNavigationView.h"
#import "FBReminderConstants.h"
#import <Masonry/Masonry.h>

@implementation FBPresentNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.goBackButton];
        
        [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self).offset(10);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)goBackButtonTapped
{
    if ([self.delegate respondsToSelector:@selector(goBackButtonTapped)]) {
        [self.delegate goBackButtonTapped];
    }
}

- (UIButton *)goBackButton
{
    if (!_goBackButton) {
        _goBackButton = [[UIButton alloc] init];
        [_goBackButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_goBackButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:kFBReminderCommonFontSize];
        [_goBackButton addTarget:self action:@selector(goBackButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackButton;
}

@end
