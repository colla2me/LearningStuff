//
//  View3Controller.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class View3Controller: UIViewController {
    
    @IBOutlet weak var blueView: SkyBlueView!
    @IBOutlet weak var pinkView: PinkView!
    @IBOutlet weak var contentView: HitTestView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        pinkView.addGestureRecognizer(makeTapGesture(#selector(tapPink)))
        contentView.addGestureRecognizer(makeTapGesture(#selector(tap)))
    }
    
    @objc private func tapBlue () {
        print("blue...");
    }
    
    @objc private func tapPink () {
        print("pink...");
    }
    
    @objc private func tap () {
        print("tap...");
    }
    
    private func makeTapGesture(_ action: Selector?) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: action)
        return tap
    }
}
