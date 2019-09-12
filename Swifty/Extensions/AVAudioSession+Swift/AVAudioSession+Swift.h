//
//  AVAudioSession+Swift.h
//  ObjCDemo
//
//  Created by Samuel on 2019/7/26.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface AVAudioSession (Swift)

/* set session category */
- (BOOL)swift_setCategory:(AVAudioSessionCategory)category error:(NSError **)error NS_SWIFT_NAME(setCategory(_:));

/* set session category with options */
- (BOOL)swift_setCategory:(AVAudioSessionCategory)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)error NS_SWIFT_NAME(setCategory(_:options:));

@end

NS_ASSUME_NONNULL_END
