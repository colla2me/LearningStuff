//
//  ViewController.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/23.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: SkyBlueView!
    @IBOutlet weak var pinkView: PinkView!
    @IBOutlet weak var contentView: HitTestView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.disableListener = false
//        blueView.addGestureRecognizer(makeTapGesture(#selector(tapBlue)))
        pinkView.addGestureRecognizer(makeTapGesture(#selector(tapPink)))
        contentView.addGestureRecognizer(makeTapGesture(#selector(tap)))
    }
    
    @IBAction func clickAction(_ sender: UIButton) {
        print("button clicked...")
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

