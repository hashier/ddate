//
//  ddateTests.m
//  ddateTests
//
//  Created by Christopher Loessl on 4/26/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "ddateTests.h"
#import "NSDate+ddate.h"

@interface ddateTests ()
@property (strong, nonatomic) NSDate *testObj;
@end

@implementation ddateTests

- (void)setUp
{
    [super setUp];
    
    self.testObj = [NSDate date];
}

- (void)tearDown
{
    self.testObj = nil;
    
    [super tearDown];
}

#pragma mark - Tests

// - (NSString *)chl_dholyday;
- (void)testHolydays {
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915497557];
    STAssertTrue([[self.testObj chl_dholyday] isEqualToString:@"Mungday"], @"Holyday, Mungday");
    
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1361236224];
    STAssertTrue([[self.testObj chl_dholyday] isEqualToString:@"Chaoflux"], @"Holyday, Chaoflux");
    
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1351037345];
    STAssertTrue([[self.testObj chl_dholyday] isEqualToString:@"Maladay"], @"Holyday, Maladay");
    
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1354928872];
    STAssertTrue([[self.testObj chl_dholyday] isEqualToString:@"Afflux"], @"Holyday, Afflux");
}

// - (NSString *)chl_dseason;
- (void)testSeason {
    // Days start at 1 not at 0
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1369529063];
    STAssertTrue([[self.testObj chl_dseason] isEqualToString:@"Discord"], @"Season, Discord");
    
    // last day of year (check if we don't get out of bounce on season)
    // I ran into that bug once
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1388467863];
    STAssertTrue([[self.testObj chl_dseason] isEqualToString:@"The Aftermath"], @"Season, The Aftermath");
}

/*
 * - (NSUInteger)chl_dyear;
 * - (NSUInteger)chl_dayInSeason;
 * - (NSString *)chl_dweekday;
 * - (NSString *)chl_dseason;
 */
- (void)testJan {
    NSString *testString;

    // 1.1.1999 (!leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915156182];
    testString = [[NSString alloc] initWithFormat:@"%@ %lu %@ %ld",
                                                  [[self.testObj chl_dweekday] description],
                                                  (unsigned long)[self.testObj chl_dayInSeason],
                                                  [[self.testObj chl_dseason] description],
                                                  (long)[self.testObj chl_dyear]];
    STAssertTrue([testString isEqualToString:@"Sweetmorn 1 Chaos 3165"], @"1.1.1999 (!leap)");

    // 1.1.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946692182];
    testString = [[NSString alloc] initWithFormat:@"%@ %lu %@ %ld",
                                                  [[self.testObj chl_dweekday] description],
                                                  (unsigned long)[self.testObj chl_dayInSeason],
                                                  [[self.testObj chl_dseason] description],
                                                  (long)[self.testObj chl_dyear]];
    STAssertTrue([testString isEqualToString:@"Sweetmorn 1 Chaos 3166"], @"1.1.2000 (leap)");
}

- (void)testMar {
    NSString *testString;

    // 25.3.1999 (!leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:922329873];
    testString = [[NSString alloc] initWithFormat:@"%@ %lu %@ %ld",
                                                  [[self.testObj chl_dweekday] description],
                                                  (unsigned long)[self.testObj chl_dayInSeason],
                                                  [[self.testObj chl_dseason] description],
                                                  (long)[self.testObj chl_dyear]];
    STAssertTrue([testString isEqualToString:@"Prickle-Prickle 11 Discord 3165"], @"23.3.1999 (!leap)");

    // 25.3.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:953952273];
    testString = [[NSString alloc] initWithFormat:@"%@ %lu %@ %ld",
                                                  [[self.testObj chl_dweekday] description],
                                                  (unsigned long)[self.testObj chl_dayInSeason],
                                                  [[self.testObj chl_dseason] description],
                                                  (long)[self.testObj chl_dyear]];
    STAssertTrue([testString isEqualToString:@"Prickle-Prickle 11 Discord 3166"], @"23.3.2000 (leap)");
}

- (void)testDec {
    NSString *testString;

    // 31.12.1999 (!leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    testString = [[NSString alloc] initWithFormat:@"%@ %lu %@ %ld",
                                                  [[self.testObj chl_dweekday] description],
                                                  (unsigned long)[self.testObj chl_dayInSeason],
                                                  [[self.testObj chl_dseason] description],
                                                  (long)[self.testObj chl_dyear]];
    STAssertTrue([testString isEqualToString:@"Setting Orange 73 The Aftermath 3165"], @"31.12.1999 (!leap)");

    // 31.12.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    testString = [[NSString alloc] initWithFormat:@"%@ %lu %@ %ld",
                                                  [[self.testObj chl_dweekday] description],
                                                  (unsigned long)[self.testObj chl_dayInSeason],
                                                  [[self.testObj chl_dseason] description],
                                                  (long)[self.testObj chl_dyear]];
    STAssertTrue([testString isEqualToString:@"Setting Orange 73 The Aftermath 3166"], @"31.12.2000 (leap)");
}

//- (NSString *)chl_ddate;
- (void)testAllInAll {
    NSString *testString;
    
    // beginning of year
    // 1.1.1999 (!leap)
    testString = @"Sweetmorn 1. Chaos, in the YOLD 3165\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915156182];
    STAssertTrue([[self.testObj chl_ddate] isEqualToString:testString], @"1.1.1999 (!leap)");

    // 1.1.2000 (leap)
    testString = @"Sweetmorn 1. Chaos, in the YOLD 3166\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946692182];
    STAssertTrue([[self.testObj chl_ddate] isEqualToString:testString], @"1.1.2000 (leap)");
    
    // end of year
    // 31.12.1999 (!leap)
    testString = @"Setting Orange 73. The Aftermath, in the YOLD 3165\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    STAssertTrue([[self.testObj chl_ddate] isEqualToString:testString], @"31.12.1999 (!leap)");

    // 31.12.2000 (leap)
    testString = @"Setting Orange 73. The Aftermath, in the YOLD 3166\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    STAssertTrue([[self.testObj chl_ddate] isEqualToString:testString], @"31.12.2000 (leap)");
    
    // 29.02.2000
    testString = @"St. Tib's Day, in the YOLD 3166";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:951822671];
    STAssertTrue([[self.testObj chl_ddate] isEqualToString:testString], @"29.02.2000 (leap)");

}

// - (BOOL)chl_isLeapYear;
- (void)testLeapYear {
    // 1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2198697464];
    STAssertFalse([self.testObj chl_isLeapYear], @"1900 is not a leap year");
    
    // 2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:956799533];
    STAssertTrue([self.testObj chl_isLeapYear], @"2000 is a leap year");
    
    // 2002
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1022288461];
    STAssertFalse([self.testObj chl_isLeapYear], @"2002 is not a leap year");

    // 2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1085446861];
    STAssertTrue([self.testObj chl_isLeapYear], @"2004 is a leap year");
}

// - (BOOL)chl_isLeapDay;
- (void)testIsLeapDay {
    // 29.2.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:951786061];
    STAssertTrue([self.testObj chl_isLeapDay], @"29.2.2000 is a leap year");
    
    // 29.2.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1078016461];
    STAssertTrue([self.testObj chl_isLeapDay], @"29.2.2004 is a leap year");
}

// - (NSString *)chl_dleapDay;
- (void)testdLeapDay {
    // Fri Feb 29 13:12:12 2008
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1204287132];
    STAssertTrue([[self.testObj chl_dleapDay] isEqualToString:@"St. Tib's Day, in the YOLD 3174"], @"Leap day 2008");
    
    // Sun Apr  1 14:12:12 2007
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1175429532];
    STAssertTrue([[self.testObj chl_dleapDay] isEqualToString:@""], @"Is not a leap day");
}

// - (NSUInteger)chl_ddayOfYear;
- (void)testDdayOfYear {
    // 31.12.1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2177535539];
    STAssertTrue([self.testObj chl_ddayOfYear] == 365, @"last day of year");
    
    // 1.1.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915152461];
    STAssertTrue([self.testObj chl_ddayOfYear] == 1, @"1st day of year");
    
    // 1.1.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946688461];
    STAssertTrue([self.testObj chl_ddayOfYear] == 1, @"1st day of year");
    
    // 1.1.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1072918861];
    STAssertTrue([self.testObj chl_ddayOfYear] == 1, @"1st day of year");

    // 31.12.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    STAssertTrue([self.testObj chl_ddayOfYear] == 365, @"last day of year");

    // 31.12.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    STAssertTrue([self.testObj chl_ddayOfYear] == 365, @"last day of a leap year");

    // 31.12.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1104454861];
    STAssertTrue([self.testObj chl_ddayOfYear] == 365, @"last day of a leap year");
}

// - (NSUInteger)chl_dayOfYear;
- (void)testDayOfYear {
    // 31.12.1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2177535539];
    STAssertTrue([self.testObj chl_dayOfYear] == 365, @"last day of year");
    
    // 1.1.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915152461];
    STAssertTrue([self.testObj chl_dayOfYear] == 1, @"1st day of year");
    
    // 1.1.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946688461];
    STAssertTrue([self.testObj chl_dayOfYear] == 1, @"1st day of year");
    
    // 1.1.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1072918861];
    STAssertTrue([self.testObj chl_dayOfYear] == 1, @"1st day of year");
    
    // 31.12.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    STAssertTrue([self.testObj chl_dayOfYear] == 365, @"last day of year");
    
    // 31.12.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    STAssertTrue([self.testObj chl_dayOfYear] == 366, @"last day of a leap year");
    
    // 31.12.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1104454861];
    STAssertTrue([self.testObj chl_dayOfYear] == 366, @"last day of a leap year");
}

/*
 * - (NSInteger)chl_day;
 * - (NSInteger)chl_month;
 * - (NSInteger)chl_year;
 */
- (void)testRestOfGregorianCalendar {
    NSString *testString;
    
    // 1.1.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915152461];
    testString = [[NSString alloc] initWithFormat:@"%ld %ld %ld",
                                                  (long)[self.testObj chl_year],
                                                  (long)[self.testObj chl_month],
                                                  (long)[self.testObj chl_day]];
    STAssertTrue([testString isEqualToString:@"1999 1 1"], @"1999 1 1");
    
    // 1.1.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946688461];
    testString = [[NSString alloc] initWithFormat:@"%ld %ld %ld",
                                                  (long)[self.testObj chl_year],
                                                  (long)[self.testObj chl_month],
                                                  (long)[self.testObj chl_day]];
    STAssertTrue([testString isEqualToString:@"2000 1 1"], @"2000 1 1");

    
    // 1.1.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1072918861];
    testString = [[NSString alloc] initWithFormat:@"%ld %ld %ld",
                                                  (long)[self.testObj chl_year],
                                                  (long)[self.testObj chl_month],
                                                  (long)[self.testObj chl_day]];
    STAssertTrue([testString isEqualToString:@"2004 1 1"], @"2004 1 1");

    
    // 31.12.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    testString = [[NSString alloc] initWithFormat:@"%ld %ld %ld",
                                                  (long)[self.testObj chl_year],
                                                  (long)[self.testObj chl_month],
                                                  (long)[self.testObj chl_day]];
    STAssertTrue([testString isEqualToString:@"1999 12 31"], @"1999 12 31");

    
    // 31.12.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    testString = [[NSString alloc] initWithFormat:@"%ld %ld %ld",
                                                  (long)[self.testObj chl_year],
                                                  (long)[self.testObj chl_month],
                                                  (long)[self.testObj chl_day]];
    STAssertTrue([testString isEqualToString:@"2000 12 31"], @"2000 12 31");

    
    // 31.12.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1104454861];
    testString = [[NSString alloc] initWithFormat:@"%ld %ld %ld",
                                                  (long)[self.testObj chl_year],
                                                  (long)[self.testObj chl_month],
                                                  (long)[self.testObj chl_day]];
    STAssertTrue([testString isEqualToString:@"2004 12 31"], @"2004 12 31");
}

@end
