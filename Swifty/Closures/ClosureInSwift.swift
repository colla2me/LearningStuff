//
//  ClosureInSwift.swift
//  Shenzhen30days
//
//  Created by Samuel on 2019/7/13.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import Foundation

class ViewModel {
    private var callback: (() -> Void)?
    
//    func whenDataLoaded(_ callback: @escaping () -> Void) {
//        self.callback = callback
//    }
    
    func whenDataLoaded<T: AnyObject>(_ t: T, _ cb: @escaping (T?) -> Void) {
        self.callback = { [weak t] in cb(t) }
    }
    
    func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let cb = self.callback { cb() }
        }
    }
    
    deinit {
        print("ViewModel deinit")
    }
}

class Controller {
    private let viewModel = ViewModel()
    
    func bind() {
        viewModel.whenDataLoaded(self) { (controller) in
            controller?.reloadUI()
        }
//        viewModel.whenDataLoaded {
//            self.reloadUI()
//        }
    }
    
    func reloadUI() {
        print("reload UI staff")
    }
    
    deinit {
        print("Controller deinit")
    }
}


// MARK: button.on.tap

class Container<Host: AnyObject>: NSObject {
    
    public unowned let host: Host
    
    public init(host: Host) {
        self.host = host
    }
}

private struct AssociatedKey {
    
    static var key = "EasyClosure_on"
}

protocol EasyClosureAware: class {
    
    associatedtype AwareHostType: AnyObject
    
    var on: Container<AwareHostType> { get }
}

extension EasyClosureAware {
    
    var on: Container<Self> {
        if let value = objc_getAssociatedObject(self, &AssociatedKey.key) as? Container<Self> {
            return value
        }
        
        let value = Container(host: self)
        objc_setAssociatedObject(self, &AssociatedKey.key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return value
    }
}

extension NSObject: EasyClosureAware { }

extension Container where Host : NSButton {
    func tap(_ action: (Host) -> Void) {
        action(host)
    }
}

let button = NSButton()

button.on.tap { (sender) in
    
}

// MARK: - With

@discardableResult
func with<T>(_ item: T, update: (inout T) throws -> Void) rethrows -> T {
    var item = item
    try update(&item)
    return item
}

let rectangle = with(CGRect(x: 0, y: 0, width: 100, height: 100)) {
    $0 = $0.offsetBy(dx: 20, dy: 20)
    $0 = $0.insetBy(dx: 10, dy: 10)
}
