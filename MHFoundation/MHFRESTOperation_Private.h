//
//  MHFRESTOperation_Private.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Dynamically Loaded. All rights reserved.
//

#import <MHFoundation/MHFRESTOperation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFRESTOperation()

@property (nonatomic, strong) id JSONObject;

@property (nonatomic, strong) NSHTTPURLResponse *response;

@end

NS_ASSUME_NONNULL_END