//
//  PlayerView.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/26.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        return self.layer as! AVPlayerLayer
    }
}
