//
//  RowView.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/09/29.
//

import SwiftUI

struct RssRowView: View {
    @State var title:String
    @State var description:String
    
    var body: some View {
        VStack {

            Text(title)
                .font(.title)
                .fontWeight(.thin)
                .multilineTextAlignment(.leading)
            Text(description)
                .font(.caption)
                .lineLimit(4)
            Spacer()
        }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct RssRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RssRowView(title: "中学で浮いてるけどなんか質問ある？" , description: "1 名前：ダイオーちゃん(埼玉県) [ES]：2021/10/01(金) 21:01:40.13 ID:pxzsf+qq0 ■セブン－イレブン、おでんにオニオンスープを誤使用　自主回収 セブン―イレブン・ジャパンは1日、近畿地方で販売したカップタイプの総菜「味しみおでん」の一部商品に誤ってオニオンスープ...")
        }
    }
}
