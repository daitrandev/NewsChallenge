//
//  RemoteFeedLoaderWithLocalFallback.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

final class RemoteFeedLoaderWithLocalFallback: FeedLoader {
    private let remoteLoader: FeedLoader
    private let localLoader: FeedLoader
    
    init(remoteLoader: FeedLoader, localLoader: FeedLoader) {
        self.remoteLoader = remoteLoader
        self.localLoader = localLoader
    }
    
    func load() async throws -> [Article] {
        []
    }
}
