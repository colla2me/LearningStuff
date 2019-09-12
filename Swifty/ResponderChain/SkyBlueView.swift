//
//  SkyBlueView.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class SkyBlueView: UIView {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("SkyBlueView::pointInside:withEvent")
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("SkyBlueView::hitTestPoint:withEvent")
        return super.hitTest(point, with: event)
    }

}
