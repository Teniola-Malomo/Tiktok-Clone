//
//  FetchVideos.swift
//  KD Tiktok-Clone
//
//  Created by Teniola Malomo on 17/04/2026.
//  Copyright © 2026 Kaishan. All rights reserved.
//

import Foundation

// MARK: - Pexels API Response

struct PexelsResponse: Codable {
    let page: Int
    let perPage: Int
    let totalResults: Int
    let videos: [PexelsVideo]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case videos
    }
}

// MARK: - Video

struct PexelsVideo: Codable {
    let id: Int
    let width: Int
    let height: Int
    let duration: Int
    let url: String
    let image: String
    let user: PexelsUser
    let videoFiles: [PexelsVideoFile]
    let videoPictures: [PexelsVideoPicture]

    enum CodingKeys: String, CodingKey {
        case id, width, height, duration, url, image, user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

// MARK: - User

struct PexelsUser: Codable {
    let id: Int
    let name: String
    let url: String
}

// MARK: - Video File

struct PexelsVideoFile: Codable {
    let id: Int
    let quality: String?
    let fileType: String?
    let width: Int?
    let height: Int?
    let fps: Double?
    let link: String
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case id, quality, width, height, fps, link, size
        case fileType = "file_type"
    }
}

// MARK: - Video Picture

struct PexelsVideoPicture: Codable {
    let id: Int
    let nr: Int
    let picture: String
}

// TODO: Step 3 — Pick the right video file (hd/sd, mp4)
