//
//  StoreService.swift
//  RestCallWithCombineFramework
//
//  Created by Gagan Vishal on 2019/09/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import Combine
 
protocol ArtistSongService {
     func fetchArtistSongList(from endPoint: EndPoint) -> Future<[SubModel], StoreAPIError>
}

enum EndPoint: String {
    case artistName = "jack+johnson"
}
