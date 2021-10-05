import UIKit
struct RssRow: Codable {
    let status: String
    //let feed: [Feed]
    let items: [Item]
    
//    struct Feed: Codable {
//        let title: String
//    }
//
    struct Item: Codable {
        let title: String
        let link: URL
    }
}

extension String {
    
    var urlEncoded: String {
        // 半角英数字 + "/?-._~" のキャラクタセットを定義
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        // 一度すべてのパーセントエンコードを除去(URLデコード)
        let removed = removingPercentEncoding ?? self
        // あらためてパーセントエンコードして返す
        return removed.addingPercentEncoding(withAllowedCharacters: charset) ?? removed
    }
}




func requestRss(query: String){
    
    let url = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=" + query.urlEncoded)!
    // URLリクエストの生成
    let request = URLRequest(url: url)
    let decoder: JSONDecoder = JSONDecoder()
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        print ("data:\(data)")
        print ("response:\(response)")
        print ("error:\(error)")
        guard let data = data else { return }
        do {
            let rssRow :RssRow = try decoder.decode(RssRow.self, from: data)
            print(rssRow.status)
            for item in rssRow.items {
                print("title:\(item.title)")
                print("link:\(item.link)")
            }
            
        } catch let e {
            print("JSON Decode Error :\(e)")
            fatalError()
            
        }
        
    }
    task.resume()
    
}



requestRss(query :"http://blog.livedoor.jp/dqnplus/index.rdf")


