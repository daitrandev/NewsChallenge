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
        try await withCheckedThrowingContinuation { continuation in
            let request = URLRequest(url: url)
            urlSession.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                
                if let data {
                    do {
                        let root = try JSONDecoder().decode(Root.self, from: data)
                        continuation.resume(returning: root.articles)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    return
                }
                continuation.resume(throwing: NSError(domain: "Fetching Feed Error", code: -1))
            }.resume()
        }
    }
}

private struct Root: Decodable {
    let articles: [ArticleDTO]
}
