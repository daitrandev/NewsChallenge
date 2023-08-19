//
//  FeedLoader.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

protocol FeedLoader {
    func load() async throws -> [Article]
}
