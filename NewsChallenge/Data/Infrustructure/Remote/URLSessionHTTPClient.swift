//
//  URLSessionHTTPClient.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get(from url: URL) async throws -> [ArticleDTO] {
        return []
    }
}
