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
        getPosts(page: 1, perPage: 80)
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
    

    
    func getPosts(page: Int, perPage: Int) {
        self.isLoading.onNext(true)

        Task {
            do {
                let response = try await PexelsAPIRequest.fetchVideos(query: "people", perPage: perPage, page: page)

                let newPosts = response.videos.compactMap { video -> Post? in
                    // Pick the best video file: HD MP4, or fall back to any MP4
                    guard let file = video.videoFiles.first(where: { $0.quality == "hd" && $0.fileType == "video/mp4" })
                            ?? video.videoFiles.first(where: { $0.fileType == "video/mp4" }) else {
                        return nil
                    }

                    return Post(
                        id: String(video.id),
                        video: file.link,
                        videoURL: URL(string: file.link),
                        videoFileExtension: "mp4",
                        videoHeight: video.height,
                        videoWidth: video.width,
                        autherID: String(video.user.id),
                        autherName: video.user.name,
                        caption: "",
                        music: "Original Sound",
                        likeCount: 0,
                        shareCount: 0,
                        commentID: ""
                    )
                }

                self.docs.append(contentsOf: newPosts)
                self.posts.onNext(self.docs)
                self.isLoading.onNext(false)
            } catch {
                self.error.onNext(error)
                self.isLoading.onNext(false)
            }
        }
    }

}
