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

- (NSString *)weekday:(NSUInteger)in {
    return @[@"Sweetmorn", @"Boomtime", @"Pungenday", @"Prickle-Prickle", @"Setting Orange"][in];
}

- (NSString *)season:(NSUInteger)in {
    return @[@"Chaos", @"Discord", @"Confusion", @"Bureaucracy", @"The Aftermath"][in];
}

- (NSString *)apostle:(NSUInteger)in {
    return @[@"Mungday", @"Mojoday", @"Syaday", @"Zaraday", @"Maladay"][in];
}

- (NSString *)holiday:(NSUInteger)in {
    return @[@"Chaoflux", @"Discoflux", @"Confuflux", @"Bureflux", @"Afflux"][in];
}

- (NSString *)chl_ddate {
    NSString *string;

    string = [self chl_dleapDay];
    if (![string isEqualToString:@""]) {
        return string;
    }
    string = [[NSString alloc] initWithFormat:@"%@ %d. %@, in the YOLD %d\n\n%@", [[self chl_dweekday] description], [self chl_dayInSeason], [[self chl_dseason] description], [self chl_dyear], [[self chl_dholyday] description]];

    return string;
}

#pragma mark - Discordian calendar

- (NSString *)chl_dleapDay {
    BOOL isLeap = [self chl_isLeapYear];
    
    if (isLeap && [self chl_month] == 2 && [self chl_day] == 29) {
        return [[NSString alloc] initWithFormat:@"St. Tib's Day, in the YOLD %d", [self chl_dyear]];
    }
    return @"";
}

- (NSInteger)chl_dyear {
    return [self chl_year] + 1166;
}

- (NSUInteger)chl_dayInSeason {
    NSUInteger ddoy = [self chl_ddayOfYear];
    return (ddoy % 73 == 0 ? 73 : ddoy % 73);
}

- (NSString *)chl_dholyday {
    NSUInteger ddoy = [self chl_ddayOfYear];
    NSUInteger dis = [self chl_dayInSeason];
    if (dis == 5) {
        return [self apostle:(ddoy / 73)];
    }
    if (dis == 50) {
        return [self holiday:(ddoy / 73)];
    }
    return @"";
}

- (NSString *)chl_dweekday {
    return [self weekday:(([self chl_ddayOfYear] - 1) % 5)];
}

- (NSString *)chl_dseason {
    return [self season:(([self chl_ddayOfYear] - 1) / 73)];
}

- (NSUInteger)chl_ddayOfYear {
    BOOL isLeap = [self chl_isLeapYear];
    NSUInteger ddoy = [self chl_dayOfYear];
    if (isLeap && ddoy >= 60) {
        ddoy--;
    }
    return ddoy;
}

#pragma mark - Gregorian calendar

- (NSUInteger)chl_dayOfYear {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger dayOfYear = [gregorian ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
    return dayOfYear;
}

- (NSInteger)chl_day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)chl_month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (NSInteger)chl_year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

- (BOOL)chl_isLeapDay {
    return [self chl_isLeapYear] && [self chl_month] == 2 && [self chl_day] == 29;
}

- (BOOL)chl_isLeapYear {
    NSInteger year = [self chl_year];
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
}

@end
