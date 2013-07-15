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

// - (NSString *)dholyday;
- (void)testHolydays {
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915497557];
    STAssertTrue([[self.testObj dholyday] isEqualToString:@"Mungday"], @"Holyday, Mungday");
    
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1361236224];
    STAssertTrue([[self.testObj dholyday] isEqualToString:@"Chaoflux"], @"Holyday, Chaoflux");
    
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1351037345];
    STAssertTrue([[self.testObj dholyday] isEqualToString:@"Maladay"], @"Holyday, Maladay");
    
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1354928872];
    STAssertTrue([[self.testObj dholyday] isEqualToString:@"Afflux"], @"Holyday, Afflux");
}

// - (NSString *)dseason;
- (void)testSeason {
    // Days start at 1 not at 0
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1369529063];
    STAssertTrue([[self.testObj dseason] isEqualToString:@"Discord"], @"Season, Discord");
    
    // last day of year (check if we don't get out of bounce on season)
    // I ran into that bug once
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1388467863];
    STAssertTrue([[self.testObj dseason] isEqualToString:@"The Aftermath"], @"Season, The Aftermath");
}

/*
 * - (NSUInteger)dyear;
 * - (NSUInteger)dayInSeason;
 * - (NSString *)dweekday;
 * - (NSString *)dseason;
 */
- (void)testJan {
    NSString *testString;
    
    // 1.1.1999 (!leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915156182];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                            [[self.testObj dweekday] description],
                            [self.testObj dayInSeason],
                            [[self.testObj dseason] description],
                            [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Sweetmorn 1 Chaos 3165"], @"1.1.1999 (!leap)");
    
    // 1.1.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946692182];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                            [[self.testObj dweekday] description],
                            [self.testObj dayInSeason],
                            [[self.testObj dseason] description],
                            [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Sweetmorn 1 Chaos 3166"], @"1.1.2000 (leap)");
}

- (void)testMar {
    NSString *testString;

    // 25.3.1999 (!leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:922329873];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                  [[self.testObj dweekday] description],
                  [self.testObj dayInSeason],
                  [[self.testObj dseason] description],
                  [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Prickle-Prickle 11 Discord 3165"], @"23.3.1999 (!leap)");

    // 25.3.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:953952273];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                  [[self.testObj dweekday] description],
                  [self.testObj dayInSeason],
                  [[self.testObj dseason] description],
                  [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Prickle-Prickle 11 Discord 3166"], @"23.3.2000 (leap)");
}

- (void)testDec {
    NSString *testString;

    // 31.12.1999 (!leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                  [[self.testObj dweekday] description],
                  [self.testObj dayInSeason],
                  [[self.testObj dseason] description],
                  [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Setting Orange 73 The Aftermath 3165"], @"31.12.1999 (!leap)");

    // 31.12.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                  [[self.testObj dweekday] description],
                  [self.testObj dayInSeason],
                  [[self.testObj dseason] description],
                  [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Setting Orange 73 The Aftermath 3166"], @"31.12.2000 (leap)");
}

//- (NSString *)ddate;
- (void)testAllInAll {
    NSString *testString;
    
    // beginning of year
    // 1.1.1999 (!leap)
    testString = @"Sweetmorn 1. Chaos, in the YOLD 3165\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915156182];
    STAssertTrue([[self.testObj ddate] isEqualToString:testString], @"1.1.1999 (!leap)");

    // 1.1.2000 (leap)
    testString = @"Sweetmorn 1. Chaos, in the YOLD 3166\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946692182];
    STAssertTrue([[self.testObj ddate] isEqualToString:testString], @"1.1.2000 (leap)");
    
    // end of year
    // 31.12.1999 (!leap)
    testString = @"Setting Orange 73. The Aftermath, in the YOLD 3165\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    STAssertTrue([[self.testObj ddate] isEqualToString:testString], @"31.12.1999 (!leap)");

    // 31.12.2000 (leap)
    testString = @"Setting Orange 73. The Aftermath, in the YOLD 3166\n\n";
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    STAssertTrue([[self.testObj ddate] isEqualToString:testString], @"31.12.2000 (leap)");
}

// - (BOOL)isLeapYear;
- (void)testLeapYear {
    // 1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2198697464];
    STAssertFalse([self.testObj isLeapYear], @"1900 is not a leap year");
    
    // 2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:956799533];
    STAssertTrue([self.testObj isLeapYear], @"2000 is a leap year");
    
    // 2002
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1022288461];
    STAssertFalse([self.testObj isLeapYear], @"2002 is not a leap year");

    // 2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1085446861];
    STAssertTrue([self.testObj isLeapYear], @"2004 is a leap year");
}

// - (BOOL)isLeapDay;
- (void)testIsLeapDay {
    // 29.2.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:951786061];
    STAssertTrue([self.testObj isLeapDay], @"29.2.2000 is a leap year");
    
    // 29.2.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1078016461];
    STAssertTrue([self.testObj isLeapDay], @"29.2.2004 is a leap year");
}

// - (NSString *)dleapDay;
- (void)testdLeapDay {
    // Fri Feb 29 13:12:12 2008
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1204287132];
    STAssertTrue([[self.testObj dleapDay] isEqualToString:@"St. Tib's Day, in the YOLD 3174"], @"Leap day 2008");
    
    // Sun Apr  1 14:12:12 2007
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1175429532];
    STAssertTrue([[self.testObj dleapDay] isEqualToString:@""], @"Is not a leap day");
}

// - (NSUInteger)ddayOfYear;
- (void)testDdayOfYear {
    // 31.12.1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2177535539];
    STAssertTrue([self.testObj ddayOfYear] == 365, @"last day of year");
    
    // 1.1.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915152461];
    STAssertTrue([self.testObj ddayOfYear] == 1, @"1st day of year");
    
    // 1.1.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946688461];
    STAssertTrue([self.testObj ddayOfYear] == 1, @"1st day of year");
    
    // 1.1.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1072918861];
    STAssertTrue([self.testObj ddayOfYear] == 1, @"1st day of year");

    // 31.12.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    STAssertTrue([self.testObj ddayOfYear] == 365, @"last day of year");

    // 31.12.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    STAssertTrue([self.testObj ddayOfYear] == 365, @"last day of a leap year");

    // 31.12.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1104454861];
    STAssertTrue([self.testObj ddayOfYear] == 365, @"last day of a leap year");
}

// - (NSUInteger)dayOfYear;
- (void)testDayOfYear {
    // 31.12.1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2177535539];
    STAssertTrue([self.testObj dayOfYear] == 365, @"last day of year");
    
    // 1.1.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915152461];
    STAssertTrue([self.testObj dayOfYear] == 1, @"1st day of year");
    
    // 1.1.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946688461];
    STAssertTrue([self.testObj dayOfYear] == 1, @"1st day of year");
    
    // 1.1.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1072918861];
    STAssertTrue([self.testObj dayOfYear] == 1, @"1st day of year");
    
    // 31.12.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    STAssertTrue([self.testObj dayOfYear] == 365, @"last day of year");
    
    // 31.12.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    STAssertTrue([self.testObj dayOfYear] == 366, @"last day of a leap year");
    
    // 31.12.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1104454861];
    STAssertTrue([self.testObj dayOfYear] == 366, @"last day of a leap year");
}

/*
 * - (NSInteger)day;
 * - (NSInteger)month;
 * - (NSInteger)year;
 */
- (void)testRestOfGregorianCalendar {
    NSString *testString;
    
    // 1.1.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:915152461];
    testString = [[NSString alloc] initWithFormat:@"%d %d %d",
                  [self.testObj year],
                  [self.testObj month],
                  [self.testObj day]];
    STAssertTrue([testString isEqualToString:@"1999 1 1"], @"1999 1 1");
    
    // 1.1.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946688461];
    testString = [[NSString alloc] initWithFormat:@"%d %d %d",
                  [self.testObj year],
                  [self.testObj month],
                  [self.testObj day]];
    STAssertTrue([testString isEqualToString:@"2000 1 1"], @"2000 1 1");

    
    // 1.1.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1072918861];
    testString = [[NSString alloc] initWithFormat:@"%d %d %d",
                  [self.testObj year],
                  [self.testObj month],
                  [self.testObj day]];
    STAssertTrue([testString isEqualToString:@"2004 1 1"], @"2004 1 1");

    
    // 31.12.1999
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:946602061];
    testString = [[NSString alloc] initWithFormat:@"%d %d %d",
                  [self.testObj year],
                  [self.testObj month],
                  [self.testObj day]];
    STAssertTrue([testString isEqualToString:@"1999 12 31"], @"1999 12 31");

    
    // 31.12.2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:978224461];
    testString = [[NSString alloc] initWithFormat:@"%d %d %d",
                  [self.testObj year],
                  [self.testObj month],
                  [self.testObj day]];
    STAssertTrue([testString isEqualToString:@"2000 12 31"], @"2000 12 31");

    
    // 31.12.2004
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1104454861];
    testString = [[NSString alloc] initWithFormat:@"%d %d %d",
                  [self.testObj year],
                  [self.testObj month],
                  [self.testObj day]];
    STAssertTrue([testString isEqualToString:@"2004 12 31"], @"2004 12 31");
}

@end
