//
//  NSOperationQueue+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSOperationQueue (MHF)

// Adds an operation and makes the last one in the queue dependent on it so it runs afterwards.
// It also ensures the queue's maxConcurrentOperationCount to 1.
- (void)mhf_addOperationAfterLast:(NSOperation *)op;

@end

NS_ASSUME_NONNULL_END