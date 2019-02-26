//
//  TenPinTests.m
//  TenPinTests
//
//  Created by Karate Bowling (2019_DEV_112) on 24/02/2019.
//  Copyright © 2019 KarateBowling. All rights reserved.
//

#import <XCTest/XCTest.h>


int calc_bowling (const char *argStr);

@interface TenPinTests : XCTestCase

@end

@implementation TenPinTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample
{
   char  *test1 = "X X X X X X X X X X X X";
   char  *test2 = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5";
   char  *test3 = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-";
   char  *test4 = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9/1";

   // This is an example of a functional test case.
   // Use XCTAssert and related functions to verify your tests produce the correct results.

   XCTAssert (calc_bowling(test1) == 300, @"Bad test for %s", test1);
   XCTAssert (calc_bowling(test2) == 150, @"Bad test for %s", test2);
   XCTAssert (calc_bowling(test3) == 90, @"Bad test for %s", test3);
   XCTAssert (calc_bowling(test4) == 92, @"Bad test for %s", test4);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
