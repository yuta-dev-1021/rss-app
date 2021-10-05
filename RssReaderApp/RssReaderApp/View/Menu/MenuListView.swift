//
//  ListView.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/09/29.
//

import SwiftUI

struct MenuListView: View {
    var body: some View {
        NavigationView {
            List(rssMenuArray) { rssMenu in
                MenuRowView(menuData: rssMenu)
            }
            .navigationBarTitle("RSS一覧", displayMode: .inline)
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MenuListView()
    }
}
