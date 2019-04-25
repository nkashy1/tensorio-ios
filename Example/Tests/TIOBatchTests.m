//
//  TIOBatchTests.m
//  TensorIO_Tests
//
//  Created by Phil Dow on 4/25/19.
//  Copyright © 2019 doc.ai (http://doc.ai)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <XCTest/XCTest.h>
#import <TensorIO/TensorIO-umbrella.h>

@interface TIOBatchTests : XCTestCase

@end

@implementation TIOBatchTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBatch {
    TIOBatch *batch = [[TIOBatch alloc] initWithKeys:@[@"image", @"label"]];
    
    [batch addItem:@{
        @"image": @[@1,@2,@3],
        @"label": @[@0]
    }];
    
    [batch addItem:@{
        @"image": @[@4,@5,@6],
        @"label": @[@1]
    }];
    
    XCTAssert(batch.count == 2);
    
    XCTAssertEqualObjects([batch itemAtIndex:0], (@{
        @"image": @[@1,@2,@3],
        @"label": @[@0]
    }));
    
    XCTAssertEqualObjects([batch itemAtIndex:1], (@{
        @"image": @[@4,@5,@6],
        @"label": @[@1]
    }));
    
    XCTAssertEqualObjects([batch valuesForKey:@"image"], (@[
        @[@1,@2,@3],
        @[@4,@5,@6]
    ]));
    
    XCTAssertEqualObjects([batch valuesForKey:@"label"], (@[
        @[@0],
        @[@1]
    ]));
}

@end
