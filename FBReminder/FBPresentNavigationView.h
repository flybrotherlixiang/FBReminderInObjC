//
//  FBPresentNavigationView.h
//  FBReminder
//
//  Created by Xiang Li on 5/29/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBPresentNavigationViewDelegate <NSObject>

- (void)goBackButtonTapped;

@end


@interface FBPresentNavigationView : UIView

@property (nonatomic) UIButton *goBackButton;
@property (nonatomic, weak) id<FBPresentNavigationViewDelegate> delegate;

@end
