//
//  SuperView.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class SuperView: UIView {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("SuperView::pointInside:withEvent")
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("SuperView::hitTestPoint:withEvent")
        return super.hitTest(point, with: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SuperView::touchesBegan:withEvent")
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SuperView::touchesEnded:withEvent")
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("SuperView::touchesCancelled:withEvent")
        super.touchesCancelled(touches, with: event)
    }
}
