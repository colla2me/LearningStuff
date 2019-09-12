//
//  HitTestView.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class HitTestView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        for sv in subviews {
//            let insidePoint = convert(point, to: sv)
//            return sv.point(inside: insidePoint, with: event)
//        }
//        return false;
        print("HitTestView::pointInside:withEvent")
        return super.point(inside: point, with: event)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        print("HitTestView::hitTestPoint:withEvent")
        return super.hitTest(point, with: event)
    }
}
