//
//  RootView.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class RootView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("RootView::pointInside:withEvent")
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("RootView::hitTestPoint:withEvent")
        return super.hitTest(point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("RootView::touchesBegan:withEvent")
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("RootView::touchesEnded:withEvent")
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("RootView::touchesCancelled:withEvent")
        super.touchesCancelled(touches, with: event)
    }

}
