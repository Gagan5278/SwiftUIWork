//
//  ArtistModel.swift
//  RestCallWithCombineFramework
//
//  Created by Gagan Vishal on 2019/09/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct Model: Codable {
    let resultCount: Int
    let results: [SubModel]
}

struct SubModel: Codable, Hashable, Equatable {
    let kind: String
    let artistId: Int
    let collectionId: Int
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let trackViewUrl: String
    let previewUrl: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let trackPrice: Double
    let releaseDate: String
    let collectionExplicitness: String
    let trackExplicitness: String
    let discCount: Int
    let discNumber: Int
    let trackCount: Int
    let trackNumber: Int
    let trackTimeMillis: Int
    let country: String
    let currency: String
    let primaryGenreName: String
    let isStreamable: Bool
    
    public func hash(into hasher: inout Hasher){
        hasher.combine(self.trackId)
    }
    
    public static func == (lhs: SubModel, rhs: SubModel) -> Bool {
        return lhs.trackId == rhs.trackId
    }
}
