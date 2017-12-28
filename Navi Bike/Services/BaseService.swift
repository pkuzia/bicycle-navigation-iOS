//
//  BaseService.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import Foundation

public struct FetchResult {
    let error: FetchError?
}

enum FetchError: Error {
    case connectionError
    case parseError
    case unknownError
    case errorMessage(String)
    
    var description: String {
        switch self {
        case .connectionError:
            return "There was an connection error"
        case .errorMessage(let error):
            return error
        case .parseError:
            return "There was an parsing error"
        case .unknownError:
            return "There was an unknown error"
        }
    }
}

class BaseService {

    
}
