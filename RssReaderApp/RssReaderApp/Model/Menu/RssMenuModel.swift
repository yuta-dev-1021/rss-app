//
//  RssMenuData.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/09/29.
//

import Foundation

var rssMenuArray:[RssMenuModel] = makeData()


// メニューに必要な情報を設定
struct RssMenuModel: Identifiable {
    var id: Int
    var title: String
    var url : String
}

func makeData()->[RssMenuModel]{
    var dataArray:[RssMenuModel] = []
    dataArray.append(RssMenuModel(id:0, title:"YahooNews：主要", url:"https://news.yahoo.co.jp/rss/topics/top-picks.xml"))
    dataArray.append(RssMenuModel(id:1, title:"YahooNews：エンタメ", url:"https://news.yahoo.co.jp/rss/topics/entertainment.xml"))
    dataArray.append(RssMenuModel(id:2, title:"YahooNews：IT", url:"https://news.yahoo.co.jp/rss/topics/it.xml"))
    
    
    return dataArray;
}
