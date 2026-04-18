//
//  PexelsAPIRequest.swift
//  KD Tiktok-Clone
//
//  Created by Teniola Malomo on 17/04/2026.
//  Copyright © 2026 Kaishan. All rights reserved.
//

import Foundation

struct PexelsAPIRequest {

    private static let baseURL = "https://api.pexels.com/videos/search"

    private static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["PexelsAPIKey"] as? String else {
            fatalError("Missing Secrets.plist or PexelsAPIKey entry")
        }
        return key
    }

    static func fetchVideos(query: String, perPage: Int, page: Int) async throws -> PexelsResponse {

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "per_page", value: String(perPage)),
            URLQueryItem(name: "page", value: String(page))
        ]

        let url = components.url!

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoded = try JSONDecoder().decode(PexelsResponse.self, from: data)

        return decoded
    }
}
