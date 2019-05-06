//
//  TIOModelRepository.h
//  TensorIO
//
//  Created by Philip Dow on 7/6/18.
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

@class TIOMRStatus;
@class TIOMRModels;
@class TIOMRModel;
@class TIOMRHyperparameters;
@class TIOMRHyperparameter;
@class TIOMRCheckpoints;
@class TIOMRCheckpoint;

NS_ASSUME_NONNULL_BEGIN

/**
 * Encapsulates requests to a TensorIO model repository, allowing users to
 * manage deployment of TensorIO models.
 *
 * All repository HTTP requests are run on a background thread and
 * execute their callbacks on the main thread.
 */

@interface TIOModelRepository : NSObject

/**
 * The base URL of the model repository
 */

@property (readonly) NSURL *baseURL;

/**
 * The URL session used by the model respository
 */

@property (readonly) NSURLSession *URLSession;

/**
 * Initializes a model repository with a base URL
 */

- (instancetype)initWithBaseURL:(NSURL*)baseURL session:(nullable NSURLSession*)URLSession NS_DESIGNATED_INITIALIZER;

/**
 * Use the designated initializer
 */

- (instancetype)init NS_UNAVAILABLE;

/**
 * Checks if the repository is up and correctly running
 */

- (NSURLSessionTask*)GETHealthStatus:(void(^)(TIOMRStatus * _Nullable response, NSError * _Nullable error))responseBlock;

/**
 * Retrieves a list of model ids for models available in the repository
 */

- (NSURLSessionTask*)GETModels:(void(^)(TIOMRModels * _Nullable response, NSError * _Nullable error))responseBlock;

/**
 * Retrieves metadata for a model with id, including the canonical hyperparameters for that model
 */

- (NSURLSessionTask*)GETModelWithId:(NSString*)modelId callback:(void(^)(TIOMRModel * _Nullable response, NSError * _Nullable error))responseBlock;

/**
 * Retrieves a list of hyperparameter ids for a model
 */

- (NSURLSessionTask*)GETHyperparametersForModelWithId:(NSString*)modelId callback:(void(^)(TIOMRHyperparameters * _Nullable response, NSError * _Nullable error))responseBlock;

/**
 * Retrieves the hyperparameters for a model by hyperparameter id
 */

- (NSURLSessionTask*)GETHyperparameterForModelWithId:(NSString*)modelId hyperparameterId:(NSString*)hyperparameterId callback:(void(^)(TIOMRHyperparameter * _Nullable response, NSError * _Nullable error))responseBlock;

/**
 * Retrieves the checkpoints for a model with the tuple (model id, hyperparameter id)
 */

- (NSURLSessionTask*)GETCheckpointsForModelWithId:(NSString*)modelId hyperparameterId:(NSString*)hyperparameterId callback:(void(^)(TIOMRCheckpoints * _Nullable response, NSError * _Nullable error))responseBlock;

/**
 * Retrieves the checkpoint for a model with the tuple (model id, hyperparameter id, checkpoint id)
 */

- (NSURLSessionTask*)GETCheckpointForModelWithId:(NSString*)modelId hyperparameterId:(NSString*)hyperparameterId checkpointId:(NSString*)checkpointId callback:(void(^)(TIOMRCheckpoint * _Nullable response, NSError * _Nullable error))responseBlock;

@end

NS_ASSUME_NONNULL_END
