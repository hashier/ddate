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

- (void)testSeason {
    // Days start at 1 not at 0
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1369529063];
    STAssertTrue([[self.testObj dseason] isEqualToString:@"Discord"], @"Season, Discord");
    
    // last day of year (check if we don't get out of bounce on season)
    // I ran into that bug once
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1388467863];
    STAssertTrue([[self.testObj dseason] isEqualToString:@"The Aftermath"], @"Season, The Aftermath");
}

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
    STAssertTrue([testString isEqualToString:@"Prickle-Prickle 11 Discord 3165"], @"1.1.1999 (!leap)");

    // 25.3.2000 (leap)
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:953952273];
    testString = [[NSString alloc] initWithFormat:@"%@ %d %@ %d",
                  [[self.testObj dweekday] description],
                  [self.testObj dayInSeason],
                  [[self.testObj dseason] description],
                  [self.testObj dyear]];
    STAssertTrue([testString isEqualToString:@"Prickle-Prickle 11 Discord 3166"], @"1.1.2000 (leap)");
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

- (void)testLeapYear {
    // 1900
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:-2198697464];
    STAssertFalse([self.testObj isLeapYear], @"1900 is not a leap year");
    
    // 2000
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:956799533];
    STAssertTrue([self.testObj isLeapYear], @"2000 is a leap year");
    
    // 2002
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1083289336];
    STAssertTrue([self.testObj isLeapYear], @"2004 is a leap year");
}

- (void)testLeapDay {
    // Fri Feb 29 13:12:12 2008
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1204287132];
    STAssertTrue([[self.testObj dleapDay] isEqualToString:@"St. Tib's Day, in the YOLD 3174"], @"Leap day 2008");
    
    // Sun Apr  1 14:12:12 2007
    self.testObj = [[NSDate alloc] initWithTimeIntervalSince1970:1175429532];
    STAssertTrue([[self.testObj dleapDay] isEqualToString:@""], @"Is not a leap day");
}

@end
