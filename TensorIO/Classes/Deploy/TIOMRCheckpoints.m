//
//  TIOMRCheckpoints.m
//  TensorIO
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

#import "TIOMRCheckpoints.h"

@implementation TIOMRCheckpoints

- (nullable instancetype)initWithJSON:(NSDictionary*)JSON {
    if ((self=[super init])) {
        if ( JSON[@"checkpointIds"] == nil || ![JSON[@"checkpointIds"] isKindOfClass:NSArray.class] ) {
            return nil;
        } else {
            _checkpointIds = JSON[@"checkpointIds"];
        }
        if ( JSON[@"hyperparametersId"] == nil || ![JSON[@"hyperparametersId"] isKindOfClass:NSString.class] ) {
            return nil;
        } else {
            _hyperparametersId = JSON[@"hyperparametersId"];
        }
        if ( JSON[@"modelId"] == nil || ![JSON[@"modelId"] isKindOfClass:NSString.class] ) {
            return nil;
        } else {
            _modelId = JSON[@"modelId"];
        }
    }
    return self;
}

- (NSString*)description {
    NSString *ms = [NSString stringWithFormat:@"Model ID: %@", self.modelId];
    NSString *hs = [NSString stringWithFormat:@"Hyperparameters ID: %@", self.hyperparametersId];
    NSString *cs = [NSString stringWithFormat:@"Checkpoint IDs: %@", self.checkpointIds];
    return [NSString stringWithFormat:@"%@\n%@\n%@", ms, hs, cs];
}

@end
