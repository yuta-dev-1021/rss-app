//
//  RssListModel.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/09/29.
//

import Foundation

struct Results: Codable {
    let items: [Item]
}

struct Item: Codable, Identifiable  {
    let id: String
    let title: String
    let link: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "pubDate"
        case title = "title"
        case link = "link"
        case description = "description"
    }
}
