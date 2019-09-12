//
//  LinkedMap.h
//  SampleOSX
//
//  Created by Samuel on 2019/5/29.
//  Copyright © 2019年 TD-tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _LinkedMapNode : NSObject {
    @package
    __unsafe_unretained _LinkedMapNode *_prev;
    __unsafe_unretained _LinkedMapNode *_next;
    id _key;
    id _value;
    NSUInteger _cost;
    NSTimeInterval _time;
}
@end

@interface _LinkedMap : NSObject {
    @package
    CFMutableDictionaryRef _dic;
    NSUInteger _totalCost;
    NSUInteger _totalCount;
    
    _LinkedMapNode *_head;
    _LinkedMapNode *_tail;
}

- (void)insertNodeAtHead:(_LinkedMapNode *)node;

- (void)bringNodeToHead:(_LinkedMapNode *)node;

- (void)removeNode:(_LinkedMapNode *)node;

- (_LinkedMapNode *)removeTailNode;

- (void)removeAll;

@end


