//
//  ContentView.swift
//  ContextMenu
//
//  Created by Gagan Vishal on 2019/09/23.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI

//1. Model
struct Places: Identifiable {
    var id = UUID().uuidString
    let placeName: String
    let placeLogoImage: String
    var isFavouritePlace: Bool
}

//2. View to display in cell
struct PlaceCell: View {
    let place : Places
    var body: some View {
        HStack {
            Image(place.placeLogoImage)
                .resizable()
                .frame(width: 45.0, height: 45.0)
                .cornerRadius(10.0)
            Text(place.placeName)
            Spacer()
            if place.isFavouritePlace {
                Image(systemName: "star.circle.fill")
            }
        }
    }
}

//3. 
struct ContentView: View {
    @State var placeList: [Places]  = [Places(placeName: "barrafina", placeLogoImage: "barrafina", isFavouritePlace: false), Places(placeName: "bourkestreetbakery", placeLogoImage: "bourkestreetbakery", isFavouritePlace: false),Places(placeName: "cafedeadend", placeLogoImage: "cafedeadend", isFavouritePlace: false),Places(placeName: "cafeloisl", placeLogoImage: "cafeloisl", isFavouritePlace: false),Places(placeName: "cafelore", placeLogoImage: "cafelore", isFavouritePlace: false),Places(placeName: "caskpubkitchen", placeLogoImage: "caskpubkitchen", isFavouritePlace: false),Places(placeName: "confessional", placeLogoImage: "confessional", isFavouritePlace: false),Places(placeName: "donostia", placeLogoImage: "donostia", isFavouritePlace: false),Places(placeName: "fiveleaves", placeLogoImage: "fiveleaves", isFavouritePlace: false),Places(placeName: "teakha", placeLogoImage: "posatelier", isFavouritePlace: false),Places(placeName: "haighschocolate", placeLogoImage: "haighschocolate", isFavouritePlace: false),Places(placeName: "homei", placeLogoImage: "homei", isFavouritePlace: false),Places(placeName: "palominoespresso", placeLogoImage: "palominoespresso", isFavouritePlace: false),Places(placeName: "petiteoyster", placeLogoImage: "petiteoyster", isFavouritePlace: false),Places(placeName: "posatelier", placeLogoImage: "posatelier", isFavouritePlace: false),Places(placeName: "palominoespresso", placeLogoImage: "teakha", isFavouritePlace: false),Places(placeName: "teakha", placeLogoImage: "teakha", isFavouritePlace: false),Places(placeName: "wafflewolf", placeLogoImage: "wafflewolf", isFavouritePlace: false)]
    
    var body: some View {
        List(placeList) { place in
            PlaceCell(place: place)
                .contextMenu {
                    Button(action: {
                        self.setFavourite(place: place)
                    }) {
                        HStack {
                            Text("Favourite")
                            Spacer()
                            Image(systemName: "star.circle.fill")
                        }
                    }
                    Button(action: {
                        self.delete(place: place)
                    }) {
                        HStack {
                            Text("Delete")
                            Image(systemName: "trash.circle.fill")
                        }
                    }
            }
        }
    }
    
    //MARK:- Set favourite place
    func setFavourite(place: Places){
        if let index  = self.placeList.firstIndex(where: {$0.id == place.id}){
            self.placeList[index].isFavouritePlace.toggle()
        }
    }
    
    //MARK:- Delete place
    func delete(place: Places){
        if let index  = self.placeList.firstIndex(where: {$0.id == place.id}){
            self.placeList.remove(at: index)
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
