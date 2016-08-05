//
//  MHFQueueOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 03/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFQueueOperation_Internal.h"
#import "MHFError.h"
#import "NSError+MHF.h"

static NSString* kOperationCountChanged = @"kOperationCountChanged";

@interface MHFQueueOperation()

@property (strong, nonatomic) NSError* error;

@end

@implementation MHFQueueOperation

-(NSOperationQueue *)operationQueue{
    if(!_operationQueue){
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.suspended = YES;
        [_operationQueue addObserver:self
                          forKeyPath:NSStringFromSelector(@selector(operationCount))
                             options:NSKeyValueObservingOptionNew
                             context:&kOperationCountChanged];
    }
    return _operationQueue;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    // if it was our observation
    if(context == &kOperationCountChanged){
        if([[change objectForKey:NSKeyValueChangeNewKey] isEqual:@0]){
            [self finishWithError:self.error];
        }
    }
    else{
        // if necessary, pass the method up the subclass hierarchy.
        if([super respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]){
            [super observeValueForKeyPath:keyPath
                                 ofObject:object
                                   change:change
                                  context:context];
        }
    }
}

-(void)performAsyncOperation{
    // start the queue after the operations have been added by the subclass.
    [self performBlockOnCallbackQueue:^{
        self.operationQueue.suspended = NO;
    }];
}

// also cancel any data task associated to this task
- (void)cancel{
    [super cancel];
    self.error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorOperationCancelled descriptionFormat:@"The %@ was cancelled", NSStringFromClass(self.class)];
    [self.operationQueue cancelAllOperations];
}

- (void)finishWithError:(NSError *)error{
    if(error){
        // might already be cancelled if cancel was called but its ok to cancel again.
        [self.operationQueue cancelAllOperations];
    }
    [super finishWithError:error];
}

- (void)addOperation:(NSOperation *)operation{
    [self.operationQueue addOperation:operation];
}

- (void)dealloc
{
    [_operationQueue removeObserver:self forKeyPath:NSStringFromSelector(@selector(operationCount))];
}

@end