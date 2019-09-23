//
//  ContentView.swift
//  CollectionViewExample
//
//  Created by Gagan Vishal on 2019/09/23.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI
import Combine

struct ImageRow: View {
    //number of rows in a cell
    let numberOfItemsInRow = 2
    var body: some View {
        //store in two dimenstional array of Int
        var images: [[Int]] = []
        //create an array of two dimnsion. A publisher that collects all received items and returns them as an array upon completion. See definition on Apple SwiftUI
        _ = (1...18).publisher.collect(numberOfItemsInRow).collect().sink(receiveValue: { images = $0 })
        return ForEach(1..<images.count, id:\.self) { array in
            HStack {
            ForEach(images[array], id:\.self) { number in
                Image("\(number)")
                .resizable()
                .scaledToFit()
            }
          }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ImageRow()
            }
            .navigationBarTitle("Collection View Demo")
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
