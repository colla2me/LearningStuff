//
//  DrawViewController.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/8/1.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

final class DrawViewController: UIViewController {
    
    private let shapeLayer = CAShapeLayer()
    private var anchorModifier = false
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.frame = CGRect(x: 120, y: 120, width: 120, height: 120)
        shapeLayer.path = UIBezierPath(roundedRect: shapeLayer.bounds, cornerRadius: 10).cgPath
        view.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func switcherAction(_ sender: UISwitch) {
        anchorModifier = sender.isOn
        stepper.value = anchorModifier ? 0.0 : 24.0
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        let step = sender.value
    
        if anchorModifier {
            let anchorPoint = CGPoint(x: step * 0.1, y: step * 0.1)
//            shapeLayer.anchorPoint = anchorPoint
            setAnchorPoint(anchorPoint, forLayer: shapeLayer)
            print("anchorPoint: \(anchorPoint), position: \(shapeLayer.position)")
        } else {
            let position = CGPoint(x: step * 10, y: step * 10)
//            shapeLayer.position = position
            setPosition(position, forLayer: shapeLayer)
            print("position: \(position), anchorPoint: \(shapeLayer.anchorPoint)")
        }
    }
    
    private func setAnchorPoint(_ anchorPoint: CGPoint, forLayer layer: CALayer) {
        let rect = layer.frame
        layer.anchorPoint = anchorPoint
        layer.frame = rect
    }
    
    private func setPosition(_ position: CGPoint, forLayer layer: CALayer) {
        let rect = layer.frame
        layer.position = position
        layer.frame = rect
    }
}
