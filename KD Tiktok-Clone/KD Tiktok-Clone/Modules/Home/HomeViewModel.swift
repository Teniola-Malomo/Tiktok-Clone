//
//  HomeViewModel.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/8/20.
//  Edited by Teniola Malomo on 18/04/2026.
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
    private let perPage = 80
    private let totalVideos = 200

    override init() {
        super.init()
        fetchAllVideos()
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

    func fetchAllVideos() {
        let totalPages = (totalVideos + perPage - 1) / perPage

        Task {
            self.isLoading.onNext(true)

            for page in 1...totalPages {
                let remaining = totalVideos - self.docs.count
                let pageCount = min(perPage, remaining)

                do {
                    let response = try await PexelsAPIRequest.fetchVideos(query: "people", perPage: pageCount, page: page)
                    let newPosts = self.convertToPosts(videos: response.videos)
                    self.docs.append(contentsOf: newPosts)
                    self.posts.onNext(self.docs)
                } catch {
                    self.error.onNext(error)
                }
            }

            self.isLoading.onNext(false)
        }
    }
    
    func convertToPosts(videos: [PexelsVideo]) -> [Post] {
        return videos.compactMap { video -> Post? in
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
    }

}
