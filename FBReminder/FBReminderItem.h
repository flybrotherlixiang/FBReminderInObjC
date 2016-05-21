//
//  FBReminderItem.h
//  FBReminder
//
//  Created by Xiang Li on 5/20/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBReminderItem : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSDate *startingDate;
@property (nonatomic) NSDate *frequency;

@end
