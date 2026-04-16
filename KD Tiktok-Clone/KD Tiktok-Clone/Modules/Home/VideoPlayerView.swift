//
//  VideoPlayerView.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/24/20.
//  Copyright © 2020 Kaishan. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlayerView: UIView {

    var videoURL: URL?
    var asset: AVURLAsset?
    var playerItem: AVPlayerItem?
    var avPlayerLayer: AVPlayerLayer!
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer?
    var observer: NSKeyValueObservation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        avPlayerLayer.frame = self.layer.bounds
    }

    func setupView(){
        avPlayerLayer = AVPlayerLayer(player: queuePlayer)
        self.layer.addSublayer(self.avPlayerLayer)
    }

    func configure(url: URL?, fileExtension: String?, size: (Int, Int)){
        avPlayerLayer.videoGravity = (size.0 < size.1) ? .resizeAspectFill : .resizeAspect
        self.layer.addSublayer(self.avPlayerLayer)

        guard let url = url else { return }
        self.videoURL = url

        self.asset = AVURLAsset(url: url)
        self.playerItem = AVPlayerItem(asset: self.asset!)
        self.addObserverToPlayerItem()

        if let queuePlayer = self.queuePlayer {
            queuePlayer.replaceCurrentItem(with: self.playerItem)
        } else {
            self.queuePlayer = AVQueuePlayer(playerItem: self.playerItem)
        }

        self.playerLooper = AVPlayerLooper(player: self.queuePlayer!, templateItem: self.queuePlayer!.currentItem!)
        self.avPlayerLayer.player = self.queuePlayer
    }

    func cancelAllLoadingRequest(){
        removeObserver()
        videoURL = nil
        asset?.cancelLoading()
        asset = nil
        playerItem = nil
        avPlayerLayer.player = nil
        playerLooper = nil
        queuePlayer = nil
    }

    func replay(){
        self.queuePlayer?.seek(to: .zero)
        play()
    }

    func play() {
        self.queuePlayer?.play()
    }

    func pause(){
        self.queuePlayer?.pause()
    }

    private func removeObserver() {
        observer?.invalidate()
        observer = nil
    }

    private func addObserverToPlayerItem() {
        self.observer = self.playerItem!.observe(\.status, options: [.initial, .new], changeHandler: { item, _ in
            switch item.status {
            case .readyToPlay:
                print("Status: readyToPlay")
            case .failed:
                print("Status: failed Error: " + (item.error?.localizedDescription ?? "unknown"))
            case .unknown:
                print("Status: unknown")
            @unknown default:
                break
            }
        })
    }
}
