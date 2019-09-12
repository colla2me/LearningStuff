//
//  NSObject+Vargs.h
//  SampleOSX
//
//  Created by Samuel on 2019/7/2.
//  Copyright © 2019 TD-tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Vargs)

+ (nullable NSArray *)parseVargsParams:(NSNumber *)count, ...NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
