//
//  RootViewController.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/29.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let slider = SWFSlider(frame: CGRect(x: 30, y: 440, width: view.frame.width - 60, height: 100))
        view.addSubview(slider)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            slider.setValue(0.9, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            slider.setValue(0.2, animated: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            slider.setValue(0.5, animated: true)
        }
        
        let slider2 = SWFSlider()
        slider2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider2)
        
        NSLayoutConstraint.activate([
            slider2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            slider2.widthAnchor.constraint(equalToConstant: 200),
            slider2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
