//
//  RssListView.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/09/29.
//

import SwiftUI

struct RssListView: View {
    //let rssData: [RssListModelItem] = mockRssListModelItem
    @State var results:Results?
    @State private var selectedRss = 0
    @ObservedObject var rssNews = RssNewsApiRequest()
    
    //
    
    var body: some View {
        //if self.rssList != nil {
        NavigationView {
            VStack {
                HStack {
                    Picker(selection:$selectedRss , label: Text("RSS選択")) {
                        ForEach(0..<rssMenuArray.count) { index in
                            Text(rssMenuArray[index].title).tag(index)
                        }
                    }
                    
                    // TODO:ボタン押さなくてもロードしたい
                    Button(action: {
                        print(rssMenuArray[self.selectedRss].url)
                        self.rssNews.load(urlParameter: rssMenuArray[self.selectedRss].url)
                    }) {
                        Text("LOAD")
                    }.background(Capsule().foregroundColor(.yellow)
                                    .frame(width: 60, height: 30))
                    .padding()
                    
                }.frame(height: 50)
                
                Spacer()
                
                if self.rssNews.results != nil {
                    List {
                        ForEach(self.rssNews.results!.items){ item in
                            NavigationLink(destination: RssWebView(url: item.link)) {
                                RssRowView(title: item.title, description: item.description)
                            }
                        }.navigationBarTitle(rssMenuArray[self.selectedRss].title)
                        .navigationBarHidden(true)
                    }
                    
                } else {
                    Text("RSSを選択してください").font(.title)
                }
                
            }
        }
    }
    
}



struct RssListView_Previews: PreviewProvider {
    static var previews: some View {
        RssListView()
    }
}
