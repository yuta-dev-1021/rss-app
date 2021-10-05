import UIKit

import Foundation


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


struct RssListModel: Codable {
    let items: [RssListModelItem]
}
struct RssListModelItem: Codable {
    let title: String
    let link: URL
}


protocol Requestable {
    associatedtype Model
    var url: String { get }
    var httpMethod: String { get }
    var headers: [String: String] { get }
    func decode(from data: Data) throws -> Model
}

extension Requestable {
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

struct RssAPIRequest: Requestable {
    typealias Model = RssListModel
    let urlParam:String
    var url: String {
        return "https://api.rss2json.com/v1/api.json?rss_url=" + urlParam.urlEncoded
    }

    var httpMethod: String {
      return "GET"
    }

    var headers: [String : String] {
      return [:]
    }
    func decode(from data: Data) throws -> RssListModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(RssListModel.self, from: data)
    }
}

class APIClient {
    func request<T: Requestable>(_ requestable: T, completion: @escaping(T.Model?) -> Void) {
        // Requestableプロトコルで定義された構造体で処理
        guard let request = requestable.urlRequest else { return }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                let model = try? requestable.decode(from: data)
                completion(model)
            }
        })
        task.resume()
    }
}

var request = RssAPIRequest(urlParam: "http://blog.livedoor.jp/dqnplus/index.rdf")
APIClient().request(request, completion: { model in
    // Optional型はguardでチェックしないと殺される
    guard let rssList:[RssListModelItem] = model?.items else {
        print("ない")
        return
    }
    for item in rssList {
        print(item.link)
        print(item.title)
    }
    
})
