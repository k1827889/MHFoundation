//
//  MHFDefines.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/05/2016.
//
//

#ifndef MHFOUNDATION_EXTERN
    #ifdef __cplusplus
        #define MHFOUNDATION_EXTERN   extern "C" __attribute__((visibility ("default")))
    #else
        #define MHFOUNDATION_EXTERN   extern __attribute__((visibility ("default")))
    #endif
#endif

#define MHFThrowMethodUnavailableException()  @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"method unavailable" userInfo:nil];

#define MHFThrowInvalidArgumentExceptionIfNil(argument)  if (!argument) { @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@#argument" cannot be nil." userInfo:nil]; }

#import <MHFoundation/MHFDefines+Namespace.h>