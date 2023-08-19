//
//  RemoteFeedLoaderWithLocalFallback.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

final class RemoteFeedLoaderWithLocalFallback: FeedLoader {
    private let mainLoader: FeedLoader
    private let fallbackLoader: FeedLoader
    
    init(remoteLoader: FeedLoader, localLoader: FeedLoader) {
        self.mainLoader = remoteLoader
        self.fallbackLoader = localLoader
    }
    
    func load() async throws -> [Article] {
        var articles: [Article] = []
        do {
            articles = try await mainLoader.load()
        } catch {
            articles = try await fallbackLoader.load()
        }
        return articles
    }
}
