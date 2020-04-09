//
//  ArticleList.swift
//  RSSReader
//
//  Created by chikushi on 2020/04/08.
//  Copyright © 2020 co.jp.vivinet. All rights reserved.
//

import Foundation

/// RSSから取得する記事リスト
struct ArticleList: Codable {
    let status: String
    let feed: Feed
    let items: [Item]
}
/// フィード
struct Feed: Codable {
    let url: String
    let title: String
    let link: String
    let author: String
    let description: String
}
/// 記事詳細
struct Item: Codable {
    let title: String
    let description: String
    let pubDate: String
    let thumbnail: String
    let link: String
    let guid: String
}
