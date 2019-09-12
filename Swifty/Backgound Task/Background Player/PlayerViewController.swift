//
//  PlayerViewController.swift
//  ObjCDemo
//
//  Created by Samuel on 2019/7/26.
//  Copyright © 2019 Shenzhen Thirtydays Technology. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlayerViewController: UIViewController {
    
    private var player = AVPlayer()
    private var playIndex = 0
    private var timeObserver: Any?
    private var statusObserver: NSKeyValueObservation?
    private var playerItemToken: NSObjectProtocol?
    private var backgroundToken: NSObjectProtocol?
    private var foregroundToken: NSObjectProtocol?
    private var playDuration: CGFloat = 0
    private var playList = [
        "https://lymanli-1258009115.cos.ap-guangzhou.myqcloud.com/video/sample/sample-video1.mp4",
        "https://lymanli-1258009115.cos.ap-guangzhou.myqcloud.com/video/sample/sample-video2.mp4"
    ]
    
    @IBOutlet weak var aspectConstraints: NSLayoutConstraint!
    @IBOutlet weak var playerSlider: UISlider!
    @IBOutlet weak var playerView: PlayerView!
    
    // MARK: Life Cycle
    
    deinit {
        if let token = backgroundToken {
            NotificationCenter.default.removeObserver(token)
        }
        if let token = foregroundToken {
            NotificationCenter.default.removeObserver(token)
        }
        if let token = playerItemToken {
            NotificationCenter.default.removeObserver(token)
        }
        self.statusObserver?.invalidate()
        if let observer = timeObserver {
            self.player.removeTimeObserver(observer)
        }
        UIApplication.shared.endReceivingRemoteControlEvents()
        self.removeCommandTargets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        setupRemoteCommandCenter()
        addObservers()
        setupPlayer()
    }
    
    // MARK: Setup Player
    
    private func setupPlayer() {
        playerView.playerLayer.player = player
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: Int32(NSEC_PER_SEC)), queue: nil) { [weak self] _ in
            self?.updateProgress()
        }
        
        let url = URL(string: playList[playIndex])!
        makePlayerItem(withURL: url)
    }
    
    private func makePlayerItem(withURL url: URL) {
        let playerItem = AVPlayerItem(url: url)
        let scale = getVideoSize(withURL: url)
        aspectConstraints.constant = scale
        
        statusObserver?.invalidate()
        statusObserver = playerItem.observe(\.status, options: [.new]) { [weak self](item, _) in
            if item.status == .readyToPlay {
                self?.updateLockScreenInfo()
            }
        }
        
        if let token = playerItemToken {
            NotificationCenter.default.removeObserver(token, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        }
        
        playerItemToken = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { [weak self](_) in
            print(">>> finished and play next one")
            self?.playNext()
        }
        
        player.replaceCurrentItem(with: playerItem)
        play()
    }
    
    private func updateProgress() {
        guard let currentItem = player.currentItem else { return }
        
        playDuration = CGFloat(CMTimeGetSeconds(currentItem.duration))
        let progress = CGFloat(CMTimeGetSeconds(currentItem.currentTime())) / playDuration
        
        playerSlider.value = Float(progress)
    }
    
    private func replay() {
        seekToTime(0) { _ in }
    }
    
    private func play() {
        player.play()
        updateLockScreenInfo()
    }
    
    private func pause() {
        player.pause()
        updateLockScreenInfo()
    }
    
    private func playNext() {
        playIndex = (playIndex + 1) % playList.count
        let url = URL(string: playList[playIndex])!
        makePlayerItem(withURL: url)
    }
    
    private func playPrevious() {
        playIndex = playIndex > 0 ? playIndex - 1 : playList.count - 1
        let url = URL(string: playList[playIndex])!
        makePlayerItem(withURL: url)
    }
    
    private func seekToTime(_ time: TimeInterval, completionHandler: @escaping (Bool) -> Void) {
        guard let playerItem = player.currentItem else {
            return
        }
        
        let timescale = playerItem.duration.timescale
        let seekTime = CMTimeMakeWithSeconds(time, preferredTimescale: timescale)
        playerItem.cancelPendingSeeks()
        playerItem.seek(to: seekTime, completionHandler: completionHandler)
//        player.seek(to: seekTime, completionHandler: completionHandler)
    }
    
    private func getVideoSize(withURL url: URL) -> CGFloat {
        let asset = AVURLAsset(url: url)
        let tracks = asset.tracks
        var size = CGSize.zero;
        if let track = tracks.first(where: { $0.mediaType == .video }) {
            size = track.naturalSize
        }
        if size.width == 0 || size.height == 0 {
            return 16.0 / 9.0
        }
        
        return size.width / size.height
    }
    
    private func addObservers() {
        backgroundToken = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self](_) in
            self?.updateLockScreenInfo()
            self?.playerView.playerLayer.player = nil
        }
        
        foregroundToken = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self](_) in
            self?.playerView.playerLayer.player = self?.player
        }
    }
    
    // MARK: Remote Command
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        let pauseCommand = commandCenter.pauseCommand
        pauseCommand.isEnabled = true
        pauseCommand.addTarget(self, action: #selector(handlePauseCommand))
        
        let playCommand = commandCenter.playCommand
        playCommand.isEnabled = true
        playCommand.addTarget(self, action: #selector(handlePlayCommand))
        
        let nextCommand = commandCenter.nextTrackCommand
        nextCommand.isEnabled = true
        nextCommand.addTarget(self, action: #selector(handleNextCommand))
        
        let previousCommand = commandCenter.previousTrackCommand
        previousCommand.isEnabled = true
        previousCommand.addTarget(self, action: #selector(handlePreviousCommand))
        
        if #available(iOS 9.1, *) {
            let positionCommand = commandCenter.changePlaybackPositionCommand
            positionCommand.isEnabled = true
            positionCommand.addTarget(self, action: #selector(handlePositionCommand))
        }
    }
    
    @objc private func handlePauseCommand() {
        pause()
    }
    
    @objc private func handlePlayCommand() {
        play()
    }
    
    @objc private func handleNextCommand() {
        playNext()
    }
    
    @objc private func handlePreviousCommand() {
        playPrevious()
    }
    
    @objc private func handlePositionCommand(_ event: MPRemoteCommandEvent) {
        let positionCommandEvent = event as! MPChangePlaybackPositionCommandEvent
        self.seekToTime(positionCommandEvent.positionTime) { _ in }
    }
    
    // MARK: Lock Screen
    
    private func updateLockScreenInfo() {
        guard let playerItem = player.currentItem else { return }
        
        let playingInfoCenter = MPNowPlayingInfoCenter.default()
        
        var playingInfo = [String: Any]()
        let index = playIndex + 1
        
        playingInfo[MPMediaItemPropertyTitle] = "歌曲 No.\(index)"
        playingInfo[MPMediaItemPropertyAlbumTitle] = "专辑 No.\(index)"
        
        if let image = UIImage(named: "cover\(index).jpg")  {
            let artwork = MPMediaItemArtwork(image: image)
            playingInfo[MPMediaItemPropertyArtwork] = artwork
        }
        
        let playbackDuration = CMTimeGetSeconds(playerItem.duration)
        let playbackTime = CMTimeGetSeconds(playerItem.currentTime())
        
        playingInfo[MPMediaItemPropertyPlaybackDuration] = playbackDuration
        playingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playbackTime
        playingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
        
        playingInfoCenter.nowPlayingInfo = playingInfo
    }
    
    // MARK: Actions
    
    @IBAction func onSliderValueChange(_ sender: UISlider) {
        if sender.value == 1.0 {
            playNext()
            return
        }
        
        if let currentItem = player.currentItem {
            let duration = CMTimeGetSeconds(currentItem.duration)
            guard !duration.isNaN else { return }
            let currentTime = TimeInterval(duration) * TimeInterval(sender.value)
            seekToTime(currentTime) { _ in }
        }
    }
    
    @IBAction func onPause(_ sender: Any) {
        pause()
    }
    
    @IBAction func onPlay(_ sender: Any) {
        play()
    }
    
    @IBAction func onPrevious(_ sender: Any) {
        playPrevious()
    }
    
    @IBAction func onNext(_ sender: Any) {
        playNext()
    }
    
    @IBAction func onDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:
    
    private func removeCommandTargets() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.removeTarget(self)
        commandCenter.pauseCommand.removeTarget(self)
        commandCenter.nextTrackCommand.removeTarget(self)
        commandCenter.previousTrackCommand.removeTarget(self)
        
        if #available(iOS 9.1, *) {
            commandCenter.changePlaybackPositionCommand.removeTarget(self)
        }
    }
}
