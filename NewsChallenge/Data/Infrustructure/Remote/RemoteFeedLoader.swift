//
//  RemoteFeedLoader.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

final class RemoteFeedLoader: FeedLoader {
    private let api: String = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9d626ed0d5984a23bc32ac5b4bcd5b31"
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() async throws -> [Article] {
        guard let url = URL(string: api) else {
            throw NSError(domain: "Api invalid", code: -1)
        }
        let articles = try await client.get(from: url)
        return articles.map { $0.mapToArticle() }
    }
}
