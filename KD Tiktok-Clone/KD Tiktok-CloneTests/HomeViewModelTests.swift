//
//  HomeViewModelTests.swift
//  KD Tiktok-CloneTests
//
//  Created by Teniola Malomo on 19/04/2026.
//  Copyright © 2026 Kaishan. All rights reserved.
//

import Testing
@testable import KD_Tiktok_Clone

struct HomeViewModelTests {

    let viewModel = HomeViewModel()

    @Test func convertToPostsPicksHdMp4() {
        let videos = [
            PexelsVideo(
                id: 1,
                width: 1920,
                height: 1080,
                duration: 10,
                url: "https://pexels.com/video/1",
                image: "https://images.pexels.com/1.jpg",
                user: PexelsUser(id: 1, name: "TestUser", url: "https://pexels.com/user/1"),
                videoFiles: [
                    PexelsVideoFile(id: 1, quality: "sd", fileType: "video/mp4", width: 640, height: 360, fps: 30.0, link: "https://videos.pexels.com/sd.mp4", size: 1000),
                    PexelsVideoFile(id: 2, quality: "hd", fileType: "video/mp4", width: 1920, height: 1080, fps: 30.0, link: "https://videos.pexels.com/hd.mp4", size: 5000)
                ],
                videoPictures: []
            )
        ]

        let posts = viewModel.convertToPosts(videos: videos)

        #expect(posts.count == 1)
        #expect(posts.first!.video == "https://videos.pexels.com/hd.mp4")
        #expect(posts.first!.autherName == "TestUser")
        #expect(posts.first!.id == "1")
    }

    @Test func convertToPostsFallsBackToSdIfNoHd() {
        let videos = [
            PexelsVideo(
                id: 2,
                width: 640,
                height: 360,
                duration: 10,
                url: "https://pexels.com/video/2",
                image: "https://images.pexels.com/2.jpg",
                user: PexelsUser(id: 1, name: "TestUser", url: "https://pexels.com/user/1"),
                videoFiles: [
                    PexelsVideoFile(id: 1, quality: "sd", fileType: "video/mp4", width: 640, height: 360, fps: 30.0, link: "https://videos.pexels.com/sd.mp4", size: 1000)
                ],
                videoPictures: []
            )
        ]

        let posts = viewModel.convertToPosts(videos: videos)

        #expect(posts.count == 1)
        #expect(posts.first!.video == "https://videos.pexels.com/sd.mp4")
    }

    @Test func convertToPostsSkipsVideoWithNoMp4() {
        let videos = [
            PexelsVideo(
                id: 3,
                width: 1920,
                height: 1080,
                duration: 10,
                url: "https://pexels.com/video/3",
                image: "https://images.pexels.com/3.jpg",
                user: PexelsUser(id: 1, name: "TestUser", url: "https://pexels.com/user/1"),
                videoFiles: [
                    PexelsVideoFile(id: 1, quality: "hd", fileType: "video/webm", width: 1920, height: 1080, fps: 30.0, link: "https://videos.pexels.com/hd.webm", size: 5000)
                ],
                videoPictures: []
            )
        ]

        let posts = viewModel.convertToPosts(videos: videos)

        #expect(posts.count == 0)
    }
}
