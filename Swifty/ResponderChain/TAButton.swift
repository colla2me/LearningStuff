//
//  TAButton.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class TAButton: UIButton {
    
    private let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
    
    var cancelsTouchesInView: Bool = false {
        didSet {
            tap.cancelsTouchesInView = cancelsTouchesInView
            if cancelsTouchesInView {
                self.addGestureRecognizer(tap)
            } else {
                self.removeGestureRecognizer(tap)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.addGestureRecognizer(tap)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func tap(_ sender: UITapGestureRecognizer) {
        print("button tap...")
    }
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print("TAButton::pointInside:withEvent")
//        return super.point(inside: point, with: event)
//    }
//
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print("TAButton::hitTestPoint:withEvent")
//        return super.hitTest(point, with: event)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan:withEvent")
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded:withEvent")
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled:withEvent")
        super.touchesCancelled(touches, with: event)
    }
}
