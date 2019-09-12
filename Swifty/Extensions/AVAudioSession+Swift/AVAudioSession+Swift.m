//
//  AVAudioSession+Swift.m
//  ObjCDemo
//
//  Created by Samuel on 2019/7/26.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

#import "AVAudioSession+Swift.h"

@implementation AVAudioSession (Swift)

- (BOOL)swift_setCategory:(AVAudioSessionCategory)category error:(NSError **)error {
    
    return [self setCategory:category error:error];
}

- (BOOL)swift_setCategory:(AVAudioSessionCategory)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)error {
    
    return [self setCategory:category withOptions:options error:error];
}

@end
