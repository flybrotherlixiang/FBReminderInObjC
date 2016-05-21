//
//  FBReminderItem.m
//  FBReminder
//
//  Created by Xiang Li on 5/20/16.
//  Copyright © 2016 Xiang Li. All rights reserved.
//

#import "FBReminderItem.h"

@interface FBReminderItem () <NSCoding>

@end

@implementation FBReminderItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(title))];
        self.detail = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(detail))];
        self.startingDate = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(startingDate))];
        self.frequency = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(frequency))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
    [aCoder encodeObject:self.detail forKey:NSStringFromSelector(@selector(detail))];
    [aCoder encodeObject:self.startingDate forKey:NSStringFromSelector(@selector(startingDate))];
    [aCoder encodeObject:self.frequency forKey:NSStringFromSelector(@selector(frequency))];
}

@end
