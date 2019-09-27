//
//  ItemDetailView.swift
//  ReadinJSONFile
//
//  Created by Gagan Vishal on 2019/09/27.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Items
    var body: some View {
        VStack {
            Image(item.picName.lowercased())
               .scaledToFit()
            Text(item.description)
               .padding()
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Items.example)
    }
}
