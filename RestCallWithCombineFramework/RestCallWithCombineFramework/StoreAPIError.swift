//
//  StoreAPIError.swift
//  RestCallWithCombineFramework
//
//  Created by Gagan Vishal on 2019/09/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

enum StoreAPIError: Error, LocalizedError {
    case urlError(URLError)
    case responseError(Int)
    case decodeError(DecodingError)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodeError(let error):
            return error.localizedDescription
        case .responseError(let status):
            return "Bad response code: \(status)"
        case .genericError:
            return "An unknwon error occurred"
        }
    }
}
