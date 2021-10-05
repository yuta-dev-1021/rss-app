//
//  RowView.swift
//  RssReaderApp
//
//  Created by 島田雄太 on 2021/09/29.
//

import SwiftUI

struct MenuRowView: View {
    var menuData: RssMenuModel
    
    var body: some View {
        HStack {
            Text(String(menuData.id))
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            Text(menuData.title)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(menuData: rssMenuArray[0])
    }
}
