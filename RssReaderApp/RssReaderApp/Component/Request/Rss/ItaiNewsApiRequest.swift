//
//  ItaiNewsApiRequest.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/10/01.
//

import Foundation


class RssNewsApiRequest: ObservableObject {
    // このプロパティに変更があった際にイベント発行
    @Published var rssListModel: RssListModel?
    
    init() {
        load()
    }

    func load() {
        // rss取得用のURL
        guard let urlParam: String = "http://blog.livedoor.jp/dqnplus/index.rdf".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            fatalError("URL Strgin error")
        }
        
        // XMLをJSONに変換してくれる素晴らしいサイトを叩く
        guard let url = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=" + urlParam) else {
            fatalError("Could'nt convert to url: https://api.rss2json.com/v1/api.json?rss_url=\(urlParam)")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                //let decoder: JSONDecoder = JSONDecoder()
                
                do {
                    let decodeData: RssListModel = try JSONDecoder().decode(RssListModel.self, from: data)
                    DispatchQueue.main.async {
                        dump(self.rssListModel)
                        self.rssListModel = decodeData
                    }
                } catch {
                    print("json convert failed in JSONDecoder. " + error.localizedDescription)
                }

            } else {
                
                fatalError("Data API Request Error")
            }
            
        }.resume()
    }
}
