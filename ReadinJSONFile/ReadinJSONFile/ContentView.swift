//
//  ContentView.swift
//  ReadinJSONFile
//
//  Created by Gagan Vishal on 2019/09/23.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @State var items = try! JSONDecoder().decode([ItemSection].self, from: NSDataAsset(name: "items", bundle: Bundle.main)!.data)
    var body: some View {
        List (items) { item in
            Section(header: Text(item.name)) {
                ForEach(item.items) { item in
                    Text("")
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
