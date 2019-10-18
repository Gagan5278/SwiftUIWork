//
//  CardView.swift
//  CardViewDemo
//
//  Created by Gagan Vishal on 2019/10/18.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI

struct CardView: View {

    var imageName: String
    var firstHeader: String
    var headingMain: String
    var SecondoryInfo: String
    
    var body: some View {
        VStack {
            Image(imageName)
             .resizable()
             .aspectRatio(contentMode: .fit)
            HStack {
                VStack (alignment: .leading){
                    Text(firstHeader)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(headingMain)
                        .font(.title)
                        .foregroundColor(.primary)
                        .lineLimit(5)
                    Text(SecondoryInfo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageName: "cloud", firstHeader: "Cloud Tail", headingMain: "Hi There this is main heading.", SecondoryInfo: "Lets fly")
    }
}
