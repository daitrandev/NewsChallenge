//
//  ArticleDTO.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import Foundation

struct ArticleDTO: Decodable {
    let author: String
    let title: String
    let description: String
    let imageUrl: String
    let content: String
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case imageUrl = "urlToImage"
        case content
    }
    
    func mapToArticle() -> Article {
        .init(author: author, title: title, description: description, imageUrl: imageUrl, content: content)
    }
}
