//
//  NSDate+ddate.h
//  ddate
//
//  Created by Christopher Loessl on 7/14/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Simple category for NSDate that provides discordian dates.

 If you want to build your own string don't forget to check for leap days.
 The name derives from the command tool ddate which returns a discordian date unter Unix/Linux systems.
 */
@interface NSDate (ddate)

#pragma mark - Discordian calendar

/**
 Returns a string that can be directly displayed. It takes care of everything like leap days and discordian holydays
 
 @return A complete ddate string which has taken care of everything.
 */
- (NSString *)ddate;

/**
 Will return an empty string on non leap days.
 
 @return On leap days it returns "St. Tib's Day, in the YOLD %d" otherwise it returns @"".
 */
- (NSString *)dleapDay;

/**
 @return Returns back the YOLD
 */
- (NSUInteger)dyear;

/**
 @return Returns the current day in the season.
 */
- (NSUInteger)dayInSeason;

/**
 @return Returns apostel (eg Mungday) or holyday (eg. Chaoflux) on holydays and @"" if date is not a holyday.
 */
- (NSString *)dholyday;

/**
 @return Retuns The weekday (eg. Sweetmorn).
 */
- (NSString *)dweekday;

/**
 @return Retuns The weekday (eg. Chaos).
 */
- (NSString *)dseason;

/**
 This returns 356 EVEN in leap years! NEEDED for ddate.
 
 @return Returns the day of the year how ddate needs it.
 */
- (NSUInteger)ddayOfYear;

#pragma mark - Gregorian calendar

/**
 This returns 366 in leap years.
 
 @return Returns day in year.
 */
- (NSUInteger)dayOfYear;

/**
 @return Returns day in month.
 */
- (NSInteger)day;

/**
 @return Returns month in year.
 */
- (NSInteger)month;

/**
 @return returns the year.
 */
- (NSInteger)year;

/**
 @return Returns TRUE in leap years.
 */
- (BOOL)isLeapYear;

/**
 Is today's day a leap day?
 
 @returns Returns TRUE if today's day is a leap day.
 */
- (BOOL)isLeapDay;

@end
