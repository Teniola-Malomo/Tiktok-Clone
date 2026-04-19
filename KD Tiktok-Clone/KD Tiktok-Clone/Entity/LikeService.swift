//
//  LikeService.swift
//  KD Tiktok-Clone
//
//  Created by Teniola Malomo on 18/04/2026.
//  Copyright © 2026 Kaishan. All rights reserved.
//

import Foundation

struct LikeService {
    private static let defaults = UserDefaults.standard

    static func like(postId: String) {
        defaults.set(true, forKey: postId)
    }

    static func unlike(postId: String) {
        defaults.removeObject(forKey: postId)
    }

    static func isLiked(postId: String) -> Bool {
        defaults.bool(forKey: postId)
    }
}

