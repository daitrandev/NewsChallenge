//
//  RemoteFeedLoader.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

final class RemoteFeedLoader: FeedLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() async throws -> [Article] {
        let articles = try await client.get(from: URL(string: "https://any-url.com")!)
        return articles.map { $0.mapToArticle() }
    }
}
