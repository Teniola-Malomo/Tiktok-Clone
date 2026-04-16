//
//  HomeViewModel.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/8/20.
//  Copyright © 2020 Kaishan. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation

class HomeViewModel: NSObject {
    
    private(set) var currentVideoIndex = 0
    
    let isLoading = BehaviorSubject<Bool>(value: true)
    let posts = BehaviorSubject<[Post]>(value: [])
    let error = PublishSubject<Error>()

    private var docs = [Post]()
    
    override init() {
        super.init()
        getPosts(pageNumber: 1, size: 10)
    }
    
    // Setup Audio
    func setAudioMode() {
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch (let err){
            print("setAudioMode error:" + err.localizedDescription)
        }
        
    }
    

    
    func getPosts(pageNumber: Int, size: Int){
        self.isLoading.onNext(true)

        // Using sample data instead of Firebase
        // Publicly accessible sample videos
        let sampleVideos = [
            "https://media.w3.org/2010/05/sintel/trailer_hd.mp4",
            "https://media.w3.org/2010/05/bunny/trailer.mp4",
            "https://media.w3.org/2010/05/bunny/movie.mp4"
        ]

        for (index, videoURLString) in sampleVideos.enumerated() {
            let post = Post(
                id: "\(index)",
                video: videoURLString,
                videoURL: URL(string: videoURLString),
                videoFileExtension: "mp4",
                videoHeight: 1920,
                videoWidth: 1080,
                autherID: "user\(index)",
                autherName: "SampleUser\(index)",
                caption: "This is a sample video #\(index + 1)",
                music: "Original Sound",
                likeCount: Int.random(in: 100...50000),
                shareCount: Int.random(in: 50...10000),
                commentID: "comment\(index)"
            )
            self.docs.append(post)
        }

        self.posts.onNext(self.docs)
        self.isLoading.onNext(false)
    }

}
