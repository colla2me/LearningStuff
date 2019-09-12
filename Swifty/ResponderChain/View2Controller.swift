//
//  View2Controller.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class View2Controller: UIViewController {

    @IBOutlet weak var sperView: SuperView!
    @IBOutlet weak var rootView: RootView!
    
    @IBOutlet weak var vipButton: TAButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        vipButton.disableListener = false
        rootView.addGestureRecognizer(makeTapGesture(#selector(tap)))
//        if let ctrl = getNearestResponder() {
//            print("getNearestViewController:", ctrl)
//        }
    }

    @IBAction func clickAction(_ sender: UIButton) {
        print("clicked...")
    }
    
    private func getNearestResponder() -> UIViewController? {
        var responder = self.next
        while (responder != nil) {
            if responder! is UIViewController {
                return (responder as! UIViewController)
            }
            responder = responder?.next
        }
        
        return nil
    }
    
    @objc private func tap () {
        print("tap...");
        vipButton.cancelsTouchesInView.toggle()
    }
    
    private func makeTapGesture(_ action: Selector?) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: action)
        return tap
    }
}
