//
//  NSDate+ddate.h
//  ddate
//
//  Created by Christopher Loessl on 7/14/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ddate)

#pragma mark - Discordian calendar
// all in all, checks for leap days and returns everything (incl. holydays)
- (NSString *)ddate;
// if you want to build your own string
// don't forget to first check if it's a leap day
- (NSString *)dleapDay; // will return an empty string on non leap days
- (NSUInteger)dyear;
- (NSUInteger)dayInSeason;
- (NSString *)dholyday;
- (NSString *)dweekday;
- (NSString *)dseason;
- (NSUInteger)ddayOfYear;

#pragma mark - Gregorian calendar
- (NSUInteger)dayOfYear;
- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;
- (BOOL)isLeapYear;
- (BOOL)isLeapDay;

@end
