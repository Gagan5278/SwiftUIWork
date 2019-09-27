//
//  CellItemRow.swift
//  ReadinJSONFile
//
//  Created by Gagan Vishal on 2019/09/27.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI

struct CellItemRow: View {
    
    let menuItem: Items
    var body: some View {
        HStack {
            Image(menuItem.thumbnailImageName.lowercased())
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            VStack {
                Text(menuItem.name)
                    .font(.headline)
                    .lineLimit(0)
                Text(String("$\(menuItem.price)"))
                    .font(.system(size: 10.0))
            }
            ForEach(menuItem.restrictions, id:\.self) { restriction in
                Text(restriction)
                    .font(.footnote)
                    .padding(10)
                    .background(Color.black)
                    .clipShape(Circle())
                    .foregroundColor(.white)

            }
        }
    }
}

struct CellItemRow_Previews: PreviewProvider {
    static var previews: some View {
        CellItemRow(menuItem: Items.example)
    }
}
