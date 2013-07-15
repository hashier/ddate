//
//  NSDate+ddate.m
//  ddate
//
//  Created by Christopher Loessl on 7/14/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "NSDate+ddate.h"

@implementation NSDate (ddate)

#pragma mark - Arrays

- (NSString *)weekday:(NSInteger)in {
    return @[@"Sweetmorn", @"Boomtime", @"Pungenday", @"Prickle-Prickle", @"Setting Orange"][in];
}

- (NSString *)season:(NSInteger)in {
    return @[@"Chaos", @"Discord", @"Confusion", @"Bureaucracy", @"The Aftermath"][in];
}

- (NSString *)apostle:(NSInteger)in {
    return @[@"Mungday", @"Mojoday", @"Syaday", @"Zaraday", @"Maladay"][in];
}

- (NSString *)holiday:(NSInteger)in {
    return @[@"Chaoflux", @"Discoflux", @"Confuflux", @"Bureflux", @"Afflux"][in];
}

- (NSString *)ddate {
    NSString *string;

    string = [self dleapDay];
    if (![string isEqualToString:@""]) {
        return string;
    }
    string = [[NSString alloc] initWithFormat:@"%@ %d. %@, in the YOLD %d\n\n%@", [[self dweekday] description], [self dayInSeason], [[self dseason] description], [self dyear], [[self dholyday] description]];

    return string;
}

#pragma mark - Discordian calendar

- (NSString *)dleapDay {
    BOOL isLeap = [self isLeapYear];
    
    if (isLeap && [self month] == 2 && [self day] == 29) {
        return [[NSString alloc] initWithFormat:@"St. Tib's Day, in the YOLD %d", [self dyear]];
    }
    return @"";
}

- (NSUInteger)dyear {
    return [self year] + 1166;
}

- (NSUInteger)dayInSeason {
    NSUInteger ddoy = [self ddayOfYear];
    return (ddoy % 73 == 0 ? 73 : ddoy % 73);
}

- (NSString *)dholyday {
    NSUInteger ddoy = [self ddayOfYear];
    NSUInteger dis = [self dayInSeason];
    if (dis == 5) {
        return [self apostle:(ddoy / 73)];
    }
    if (dis == 50) {
        return [self holiday:(ddoy / 73)];
    }
    return @"";
}

- (NSString *)dweekday {
    return [self weekday:(([self ddayOfYear] - 1) % 5)];
}

- (NSString *)dseason {
    return [self season:(([self ddayOfYear] - 1) / 73)];
}

- (NSUInteger)ddayOfYear {
    BOOL isLeap = [self isLeapYear];
    NSUInteger ddoy = [self dayOfYear];
    if (isLeap && ddoy >= 60) {
        ddoy--;
    }
    return ddoy;
}

#pragma mark - Gregorian calendar

- (NSUInteger)dayOfYear {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger dayOfYear = [gregorian ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
    return dayOfYear;
}

- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

- (BOOL)isLeapDay {
    if ([self isLeapYear] && [self month] == 2 && [self day] == 29) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isLeapYear {
    NSUInteger year = [self year];
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
