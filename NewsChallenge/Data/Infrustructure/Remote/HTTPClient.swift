//
//  HTTPClient.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL) async throws -> [ArticleDTO]
}
