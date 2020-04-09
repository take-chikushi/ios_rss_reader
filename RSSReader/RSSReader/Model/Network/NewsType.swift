//
//  NewsType.swift
//  RSSReader
//
//  Created by chikushi on 2020/04/08.
//  Copyright © 2020 co.jp.vivinet. All rights reserved.
//

import Foundation

/// ニュースの種別
enum NewsType: CaseIterable {
    case main
    case it
    case game
    
    /// RSS取得用url
    var urlStr: String {
        switch self {
        case .main:
            return "https://api.rss2json.com/v1/api.json?rss_url=http://b.hatena.ne.jp/hotentry.rss"
        case .it:
         return "https://api.rss2json.com/v1/api.json?rss_url=https://b.hatena.ne.jp/hotentry/it.rss"
        case .game:
        return "https://api.rss2json.com/v1/api.json?rss_url=http://b.hatena.ne.jp/hotentry/game.rss"
        }
    }
    
    /// ページメニュータイトル用文字列
    var itemInfo: String {
        switch self {
        case .main: return "総合"
        case .it: return "テクノロジー"
        case .game: return "アニメとゲーム"
        }
    }
}
