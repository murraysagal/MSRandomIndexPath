//
//  MSRandomIndexPathTests.m
//  MSRandomIndexPathTests
//
//  Created by Murray Sagal on 2/26/2014.
//  Copyright (c) 2014 Murray Sagal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSIndexPath+RandomAdditions.h"

@interface MSRandomIndexPathTests : XCTestCase

@property (strong, nonatomic) NSArray *array0;
@property (strong, nonatomic) NSArray *array1;
@property (strong, nonatomic) NSArray *array2;

@property (strong, nonatomic) NSArray *arrays;

@end

@implementation MSRandomIndexPathTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.array0 = @[ @1, @2,  @3,  @4 ];
    self.array1 = @[ @5, @6,  @7,  @8 ];
    self.array2 = @[ @9, @10, @11, @12 ];
    
    self.arrays = @[ self.array0, self.array1, self.array2 ];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testArraysIsNil {
    
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:nil excludingIndexPaths:nil];
    XCTAssertNil(randomIndexPath, @"Fail: Arrays nil, randomIndexPath should be nil but was not.");
}

- (void)testEmptyArray {
    
    self.arrays = @[ self.array0, [NSArray array], self.array2 ];
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:self.arrays excludingIndexPaths:nil];
    XCTAssertNil(randomIndexPath, @"Fail: Arrays contains one empty array, randomIndexPath should be nil but was not.");
}

- (void)testArraysContainsNonArrayObject {
    
    self.arrays = @[ self.array0, @1, self.array2 ];
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:self.arrays excludingIndexPaths:nil];
    XCTAssertNil(randomIndexPath, @"Fail: Arrays contains a non-array object, randomIndexPath should be nil but was not.");
}

- (void)testExcludedNil {
    
    NSSet *excludedIndexPaths = nil;
    NSArray *arrays = @[ self.array0 ];
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:arrays excludingIndexPaths:excludedIndexPaths];
    XCTAssertNotNil(randomIndexPath, @"Fail: excludedIndexPaths is nil, randomIndexPath should not be nil but was.");
}

- (void)testExcludedEmpty {
    
    NSSet *excludedIndexPaths = [NSSet set];
    NSArray *arrays = @[ self.array0 ];
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:arrays excludingIndexPaths:excludedIndexPaths];
    XCTAssertNotNil(randomIndexPath, @"Fail: excludedIndexPaths is empty, randomIndexPath should not be nil but was.");
}

- (void)testTooManyExcluded {
    
    NSIndexPath *indexPath0 = [NSIndexPath indexPathForItem:0 inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];
    NSSet *excludedIndexPaths = [NSSet setWithObjects:indexPath0, indexPath1, indexPath2, indexPath3, nil];
    
    NSArray *arrays = @[ self.array0 ];
    
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:arrays excludingIndexPaths:excludedIndexPaths];
    XCTAssertNil(randomIndexPath, @"Fail: Too many excluded index paths, randomIndexPath should be nil but was not.");
    
}

- (void)testOnlyOneOption_00 {
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];
    NSSet *excludedIndexPaths = [NSSet setWithObjects:indexPath1, indexPath2, indexPath3, nil];
    
    NSArray *arrays = @[ self.array0 ];
    
    NSIndexPath *expectedResult = [NSIndexPath indexPathForItem:0 inSection:0];
    
    NSIndexPath *randomIndexPath = [NSIndexPath randomIndexPathInArrays:arrays excludingIndexPaths:excludedIndexPaths];
    XCTAssertEqualObjects(randomIndexPath, expectedResult, @"Fail: Excluded index paths leave only one possbile result which was not returned.");
    
}

- (void)testExcludeInLoop {
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:2 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:2 inSection:1];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:2 inSection:2];
    NSSet *excludedIndexPaths = [NSSet setWithObjects:indexPath1, indexPath2, indexPath3, nil];
    
    NSIndexPath *randomIndexPath;

    for (int i=0; i<1000; i++) {
        randomIndexPath = [NSIndexPath randomIndexPathInArrays:self.arrays excludingIndexPaths:excludedIndexPaths];
        XCTAssertFalse([excludedIndexPaths containsObject:randomIndexPath], @"Fail: randomIndexPath is in the set of excluded indext paths.");
    }
}

@end
