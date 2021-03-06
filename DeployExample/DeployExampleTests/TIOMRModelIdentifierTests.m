//
//  TIOMRIdentifierTests.m
//  DeployExampleTests
//
//  Created by Phil Dow on 5/15/19.
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

@interface TIOMRIdentifierTests : XCTestCase

@end

@implementation TIOMRIdentifierTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testModelIdentifierInitializerSetsProperties {
    TIOMRModelIdentifier *identifier = [[TIOMRModelIdentifier alloc] initWithModelId:@"model-id" hyperparametersId:@"hyp-id" checkpointsId:@"ch-id"];
    
    XCTAssertEqualObjects(identifier.modelId, @"model-id");
    XCTAssertEqualObjects(identifier.hyperparametersId, @"hyp-id");
    XCTAssertEqualObjects(identifier.checkpointId, @"ch-id");
}

- (void)testModelIdentifierInitializesWithCorrectlyFormattedBundleId {
    NSString *bundleId = @"tio:///models/model-id/hyperparameters/hyp-id/checkpoints/ch-id";
    TIOMRModelIdentifier *identifier = [[TIOMRModelIdentifier alloc] initWithBundleId:bundleId];
    
    XCTAssertNotNil(identifier);
    XCTAssertEqualObjects(identifier.modelId, @"model-id");
    XCTAssertEqualObjects(identifier.hyperparametersId, @"hyp-id");
    XCTAssertEqualObjects(identifier.checkpointId, @"ch-id");
}

- (void)testModelIdentifierDoesNotInitializeWithIncorrectlyFormattedBundleId {
    NSString *bundleId = @"tio:///models/model-id/";
    TIOMRModelIdentifier *identifier = [[TIOMRModelIdentifier alloc] initWithBundleId:bundleId];
    XCTAssertNil(identifier);
    
    NSString *bundleId2 = @"mobilenet-v2";
    TIOMRModelIdentifier *identifier2 = [[TIOMRModelIdentifier alloc] initWithBundleId:bundleId2];
    XCTAssertNil(identifier2);
}

@end
