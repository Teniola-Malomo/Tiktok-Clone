//
//  Post.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/8/20.
//  Copyright © 2020 Kaishan. All rights reserved.
//

import Foundation

struct Post: Codable{
    var id: String
    var video: String
    var videoURL: URL?
    var videoFileExtension: String?
    var videoHeight: Int
    var videoWidth: Int
    var autherID: String
    var autherName: String
    var caption: String
    var music: String
    var likeCount: Int
    var shareCount: Int
    var commentID: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case video
        case videoURL
        case videoFileExtension
        case videoHeight
        case videoWidth
        case autherID = "author"
        case autherName
        case caption
        case music
        case likeCount
        case shareCount
        case commentID
    }
    
    init(id: String, video: String, videoURL: URL? = nil, videoFileExtension: String? = nil, videoHeight: Int, videoWidth: Int, autherID: String, autherName: String, caption: String, music: String, likeCount: Int, shareCount: Int, commentID: String) {
        self.id = id
        self.video = video
        self.videoURL = videoURL ?? URL(fileURLWithPath: "")
        self.videoFileExtension = videoFileExtension ?? "mp4"
        self.videoHeight = videoHeight
        self.videoWidth = videoWidth
        self.autherID = autherID
        self.autherName = autherName
        self.caption = caption
        self.music = music
        self.likeCount = likeCount
        self.shareCount = shareCount
        self.commentID = commentID
    }
    
}

