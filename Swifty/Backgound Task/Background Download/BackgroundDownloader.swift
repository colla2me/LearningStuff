//
//  BackgroundDownloader.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/8/2.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import Foundation

final class BackgroundDownloader: NSObject, URLSessionDownloadDelegate {
    
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    private let downloadQueue = OperationQueue()
    
    private let taskIdentifier: String = {
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        return bundleIdentifier.appending(".backgroundSession")
    }()
    
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: taskIdentifier)
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        configuration.httpMaximumConnectionsPerHost = 4
        return URLSession(configuration: configuration, delegate: self, delegateQueue: downloadQueue)
    }()
    
    
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Background Notification
    
    @objc private func didEnterBackground(notification: Notification) {
        self.backgroundTask = UIApplication.shared.beginBackgroundTask(withName: taskIdentifier) {
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }
    }
    
    // MARK: URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print(">>>>>> urlSession(_, downloadTask:, didFinishDownloadingTo:)")
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
        print(">>>>>> urlSessionDidFinishEvents(forBackgroundURLSession:)")
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print(">>>>>> urlSessionDidFinishEvents(forBackgroundURLSession:)")
    }
}
