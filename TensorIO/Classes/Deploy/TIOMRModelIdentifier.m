//
//  TIOMRModelIdentifier.m
//  TensorIO
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
#import "TIOMRModelIdentifier.h"

@implementation TIOMRModelIdentifier

- (instancetype)initWithModelId:(NSString*)modelId hyperparametersId:(NSString*)hyperparametersId checkpointsId:(NSString*)checkpointId {
    if ((self=[super init])) {
        _modelId = modelId;
        _hyperparametersId = hyperparametersId;
        _checkpointId = checkpointId;
    }
    return self;
}

- (nullable instancetype)initWithBundleId:(NSString*)bundleId {
    NSURL *URL = [NSURL URLWithString:bundleId];
    
    if ( ![URL.scheme isEqualToString:@"tio"] ) {
        return nil;
    }
    
    NSArray<NSString*> *components = URL.pathComponents;
    
    if ( components.count != 7 ) {
        return nil;
    }
    
    if (   ![components[1] isEqualToString:@"models"]
        || ![components[3] isEqualToString:@"hyperparameters"]
        || ![components[5] isEqualToString:@"checkpoints"] ) {
        return nil;
    }

    return [self initWithModelId:components[2] hyperparametersId:components[4] checkpointsId:components[6]];
}

@end
