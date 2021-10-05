//
//  RssWebView.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/10/04.
//

import SwiftUI
import WebKit

struct RssWebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}

struct RssWebView_Previews: PreviewProvider {
    static var previews: some View {
        RssWebView(url: "https://news.yahoo.co.jp/pickup/6406164?source=rss")
    }
}
