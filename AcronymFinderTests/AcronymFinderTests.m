//
//  AcronymFinderTests.m
//  AcronymFinderTests
//
//  Created by Qi Zhan on 1/28/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AcronymFinderTests : XCTestCase

@end

@implementation AcronymFinderTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSLog(@"Unit test ---- setUp");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    NSLog(@"Unit test ----- tearDown");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSLog(@"Unit test ----- testExample");
    assert(true);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
