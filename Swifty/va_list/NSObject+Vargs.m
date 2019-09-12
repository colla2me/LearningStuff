//
//  NSObject+Vargs.m
//  SampleOSX
//
//  Created by Samuel on 2019/7/2.
//  Copyright © 2019 TD-tech. All rights reserved.
//

#import "NSObject+Vargs.h"

@implementation NSObject (Vargs)

+ (nullable NSArray *)parseVargsParams:(NSNumber *)params, ...NS_REQUIRES_NIL_TERMINATION {
    va_list args;
    if (params) {
        va_start(args, params);
        id val = nil;
        NSMutableArray *array = [NSMutableArray arrayWithObject:params];
        while ((val = va_arg(args, NSNumber *))) {
            NSLog(@"arg: %@", val);
            [array addObject:val];
        }
        va_end(args);
        return array;
    }
    
    return nil;
}

@end
