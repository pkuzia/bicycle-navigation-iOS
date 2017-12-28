//
//  BaseService.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import Foundation
import RealmSwift

public struct FetchResult {
    let error: FetchError?
}

enum FetchError: Error {
    case connectionError
    case parseError
    case databaseError
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
        case .databaseError:
            return "There was an database error"
        case .unknownError:
            return "There was an unknown error"
        }
    }
}

class BaseService {
    
    func writeArray<T: BaseModel>(fetchResult: FetchResult, array: [T]?,
                    completionHandler: @escaping (FetchResult, [T]?) -> ()) {
        
        if fetchResult.error != nil {
            completionHandler(fetchResult, nil)
        } else if let items = array {
            do {
                let realm = try Realm()
                try realm.write {
                    for item in items {
                        realm.add(item, update: true)
                    }
                    completionHandler(fetchResult, array)
                }
            } catch _ {
                completionHandler(FetchResult(error: .databaseError), array)
            }
        }
    }
}
