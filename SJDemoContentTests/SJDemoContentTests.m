//
//  SJContentManagerTests.m
//  SJContentManagerTests
//
//  Created by Shane Gianelli on 3/12/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJDemoContentTests"

#import "SJContent.h"

@implementation SJDemoContentTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in SJContentManagerTests");
    
    for (int i = 0; i < 10000; i++) {
        float n = [SJContent floatInRange:NSMakeRange(23412, 351)];
        STAssertTrue(n >= 23412 && n < 23763, @"Random float out of range: %f",n);
    }
}

@end
