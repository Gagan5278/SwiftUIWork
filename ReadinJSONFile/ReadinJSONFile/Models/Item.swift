//
//  ItemSection.swift
//  ReadinJSONFile
//
//  Created by Gagan Vishal on 2019/09/23.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct ItemSection: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let items: [Items]
}

struct Items: Codable, Identifiable,Hashable {
    let id: String
    let name: String
    let photoCredit: String
    let price: Double
    let restrictions: [String]
    let description: String
    
}
