//
//  AllFeedsViewModel.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation
import Combine

protocol AddFeedsViewModelType {
    var loader: FeedLoader { get }
    var articles: PassthroughSubject<[Article], Never> { get }
    func fetch() async throws
}

final class AllFeedsViewModel: AddFeedsViewModelType {
    
    let loader: FeedLoader
    var articles: PassthroughSubject<[Article], Never> = .init()
    
    init(loader: FeedLoader) {
        self.loader = loader
    }
    
    func fetch() async throws {
        let loadResult = try await loader.load()
        articles.send(loadResult)
    }
}
