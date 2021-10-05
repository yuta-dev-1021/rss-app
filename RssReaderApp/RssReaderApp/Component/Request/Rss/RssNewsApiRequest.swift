//
//  ItaiNewsApiRequest.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/10/01.
//

import Foundation


class RssNewsApiRequest: ObservableObject {
    // このプロパティに変更があった際にイベント発行
    @Published var results:Results?

    func load(urlParameter: String) ->() {
        print("RssNewsApiRequest：load:START")
        // rss取得用のURL
        guard let urlParam: String = urlParameter.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            fatalError("URL Strgin error")
        }
        print("urlParam SET")
        // XMLをJSONに変換してくれる素晴らしいサイトを叩く
        guard let url = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=" + urlParam) else {
            fatalError("Could'nt convert to url: https://api.rss2json.com/v1/api.json?rss_url=\(urlParam)")
        }
        print("url SET")
        print("URLSession 開始")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let jsonData = data {
                
                //let decoder: JSONDecoder = JSONDecoder()
                let decodedData:Results?
                do {
                    print("decode 開始")
                    decodedData = try JSONDecoder().decode(Results.self, from: jsonData)
                    
                    dump(decodedData)
                    
                } catch let error{
                    print(error)
                    fatalError("Couldn't decode JSON Data")
                }
                print("decode 完了")
                DispatchQueue.main.async {
                    self.results = decodedData
                }

            } else{
                print("Data API Request Error")
                fatalError("Data API Request Error")
            }
            
        }.resume()
        print("URLSession 終了")
        print("RssNewsApiRequest：load:END")
    }
}
