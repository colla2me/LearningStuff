//
//  BackgroundOperation.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/8/2.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit

final public class BackgroundOperation: ConcurrentOperation {
    
    public enum Result {
        case failed(reason: Error)
        case success(attachment: DownloadAttachment)
    }
    
    private let attachment: DownloadAttachment
    
    init(attachment: DownloadAttachment) {
        self.attachment = attachment
        super.init()
    }
    
    public override func main() {
        
    }
}
