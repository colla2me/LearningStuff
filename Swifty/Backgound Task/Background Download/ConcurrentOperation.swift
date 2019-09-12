//
//  ConcurrentOperation.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/8/2.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

public class ConcurrentOperation: Operation {

    enum State: String {
        case Ready, Executing, Finished
        
        private var keyPath: String {
            return "is" + rawValue
        }
    }
    
    var state = State.Ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
}

public extension ConcurrentOperation {
    
    override var isReady: Bool {
        return super.isReady && state == .Ready
    }
    
    override var isExecuting: Bool {
        return state == .Executing
    }
    
    override var isFinished: Bool {
        return state == .Finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .Finished
            return
        }
        
        main()
        state = .Executing
    }
    
    override func cancel() {
        state = .Finished
    }
}
