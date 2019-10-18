//
//  ContentView.swift
//  CardViewDemo
//
//  Created by Gagan Vishal on 2019/10/18.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI
//This struct can be used as a data model.
struct Items: Identifiable {
    var id = UUID().uuidString
    let imageName: String
}
struct ContentView: View {
    
    let arrayOfImages = [Items(imageName: "cloud"),Items(imageName: "coffee"),Items(imageName: "food"),Items(imageName: "pmq")]
    var body: some View {
        List(arrayOfImages) { image in
            CardView(imageName: image.imageName, firstHeader: "Hi There,First Header", headingMain: "Hi There, this is the main header for the card.", SecondoryInfo: "Sub info goes here")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
