//
//  TIOMRDownload.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TIOMRDownload : NSObject

/**
 * The file URL location of the download
 */

@property (readonly) NSURL *URL;

/**
 * The id of the model with which this download is associated
 */

@property (readonly) NSString *modelId;

/**
 * The hyperparameter id with which this download is associated
 */

@property (readonly) NSString *hyperparametersId;

/**
 * The checkpoint id with which this download is associated
 */

@property (readonly) NSString *checkpointId;

/**
 * Encpasulates information about a download from a model respository.
 *
 * You should not need to instantiate instances of this class yourself. They
 * are retured by requests to a `TIOModelRepository`.
 */

- (instancetype)initWithURL:(NSURL*)URL modelId:(NSString*)modelId hyperparametereId:(NSString*)hyperparametersId checkpointId:(NSString*)checkpointId NS_DESIGNATED_INITIALIZER;

/**
 * Use the designated initializer.
 */

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
