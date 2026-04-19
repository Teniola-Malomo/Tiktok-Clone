//
//  PexelsAPITests.swift
//  KD Tiktok-CloneTests
//
//  Created by Teniola Malomo on 19/04/2026.
//  Copyright © 2026 Kaishan. All rights reserved.
//

import Testing
@testable import KD_Tiktok_Clone

struct PexelsAPITests {

    let response: PexelsResponse
    let video: PexelsVideo

    init() async throws {
        response = try await PexelsAPIRequest.fetchVideos(query: "people", perPage: 10, page: 1)
        video = response.videos.first!
    }

    @Test func fetchVideosReturnsData() {
        #expect(!response.videos.isEmpty)
        #expect(response.perPage == 10)
        #expect(response.page == 1)
    }

    @Test func videoHasRequiredFields() {
        #expect(video.id > 0)
        #expect(!video.user.name.isEmpty)
        #expect(!video.videoFiles.isEmpty)
        #expect(!video.image.isEmpty)
    }

    @Test func videoHasMp4File() {
        let mp4File = video.videoFiles.first(where: { $0.fileType == "video/mp4" })
        #expect(mp4File != nil)
        #expect(!mp4File!.link.isEmpty)
    }
    
}
