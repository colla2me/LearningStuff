//
//  Box.swift
//  SwiftOSX
//
//  Created by Samuel on 2019/5/13.
//  Copyright © 2019年 Shenzhen Thirtydays Technology. All rights reserved.
//

import Foundation

final class Ref<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

struct Box<T> {
    private var ref: Ref<T>
    init(value: T) {
        ref = Ref(value: value)
    }
    
    var value: T {
        get { return ref.value }
        set {
            guard isKnownUniquelyReferenced(&ref) else {
                ref = Ref(value: newValue)
                return
            }
            ref.value = newValue
        }
    }
}
