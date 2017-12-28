//
//  ExampleViewModel.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import UIKit
import Moya_ObjectMapper

protocol ExampleViewModelDelegate: class {
    
}

class ExampleViewModel: BaseViewModel {
    
    weak var delegate: ExampleViewModelDelegate?
    let repositoryService = RepositoryService()
    
    var respositories = [Repository]()
    
    func getRepositories(_ username: String, completionHandler: @escaping (FetchResult) -> ()) {
        repositoryService.getRepositories(username) { fetchResult, respositories in
            DispatchQueue.main.async {
                if fetchResult.error != nil {
                    completionHandler(fetchResult)
                } else {
                    if let respositories = respositories {
                        self.respositories = respositories
                        completionHandler(FetchResult(error: nil))
                    } else {
                        completionHandler(FetchResult(error: .unknownError))
                    }
                }
                
            }
        }
    }
}
