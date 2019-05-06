//
//  TIOMRCheckpointTests.m
//  DeployExampleTests
//
//  Created by Phil Dow on 5/6/19.
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
//  TODO: Test URL

#import <XCTest/XCTest.h>
#import <TensorIO/TensorIO-umbrella.h>
#import "MockURLSession.h"

@interface TIOMRCheckpointTests : XCTestCase

@end

@implementation TIOMRCheckpointTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGETCheckpointWithCheckpointPropertieSucceeds {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"modelId": @"happy-face",
        @"hyperparameterId": @"batch-9-2-0-1-5",
        @"checkpointId": @"model.ckpt-321312",
        @"createdAt": @"1549868901",
        @"info": @{
            @"standard-1-accuracy": @"0.934"
        },
        @"link": @"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqualObjects(response.modelId, @"happy-face");
        XCTAssertEqualObjects(response.hyperparameterId, @"batch-9-2-0-1-5");
        XCTAssertEqualObjects(response.checkpointId, @"model.ckpt-321312");
        XCTAssertEqualObjects(response.createdAt, [NSDate dateWithTimeIntervalSince1970:[@"1549868901" doubleValue]]);
        XCTAssertEqualObjects(response.link, [NSURL URLWithString:@"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"]);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutModelIdFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"hyperparameterId": @"batch-9-2-0-1-5",
        @"checkpointId": @"model.ckpt-321312",
        @"createdAt": @"1549868901",
        @"info": @{
            @"standard-1-accuracy": @"0.934"
        },
        @"link": @"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutHyperparameterIdFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"modelId": @"happy-face",
        @"checkpointId": @"model.ckpt-321312",
        @"createdAt": @"1549868901",
        @"info": @{
            @"standard-1-accuracy": @"0.934"
        },
        @"link": @"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutCheckpointIdFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"modelId": @"happy-face",
        @"hyperparameterId": @"batch-9-2-0-1-5",
        @"createdAt": @"1549868901",
        @"info": @{
            @"standard-1-accuracy": @"0.934"
        },
        @"link": @"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutCreatedAtFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"modelId": @"happy-face",
        @"hyperparameterId": @"batch-9-2-0-1-5",
        @"checkpointId": @"model.ckpt-321312",
        @"info": @{
            @"standard-1-accuracy": @"0.934"
        },
        @"link": @"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutInfoFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"modelId": @"happy-face",
        @"hyperparameterId": @"batch-9-2-0-1-5",
        @"checkpointId": @"model.ckpt-321312",
        @"createdAt": @"1549868901",
        @"link": @"https://storage.googleapis.com/doc-ai-models/happy-face/batch-9-2-0-9-2-0/model.ckpt-322405.zip"
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutLinkFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONResponse:@{
        @"modelId": @"happy-face",
        @"hyperparameterId": @"batch-9-2-0-1-5",
        @"checkpointId": @"model.ckpt-321312",
        @"createdAt": @"1549868901",
        @"info": @{
            @"standard-1-accuracy": @"0.934"
        }
    }];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithErrorFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithError:[[NSError alloc] init]];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

- (void)testGETCheckpointWithoutDataFails {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Wait for checkpoint response"];
    
    MockURLSession *session = [[MockURLSession alloc] initWithJSONData:[NSData data]];
    
    TIOModelRepository *repository = [[TIOModelRepository alloc] initWithBaseURL:[NSURL URLWithString:@""] session:session];
    
    MockSessionDataTask *task = (MockSessionDataTask*)[repository GETCheckpointForModelWithId:@"happy-face" hyperparameterId:@"batch-9-2-0-1-5" checkpointId:@"model.ckpt-321312" callback:^(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        XCTAssertNil(response);
        [expectation fulfill];
    }];
    
    XCTAssert(task.calledResume);
    [self waitForExpectations:@[expectation] timeout:1.0];
}

@end
