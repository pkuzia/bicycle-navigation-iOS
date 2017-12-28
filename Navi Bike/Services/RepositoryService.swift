//
//  RepositoryService.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import Foundation

// MARK: Database

class RepositoryService: BaseService {
    
    fileprivate func getRepositoriesFromAPI(_ username: String,
                                            completionHandler: @escaping (FetchResult, [Repository]?) -> ()) {
        
        GitHubProvider.request(.userRepositories(username), completion: { result in
            
            switch result {
            case let .success(response):
                do {
                    let repositories: [Repository]? = try response.mapArray(Repository.self)
                    
                    if let repositories = repositories {
                        completionHandler(FetchResult(error: nil), repositories)
                    } else {
                        completionHandler(FetchResult(error: .parseError), nil)
                    }
                } catch {
                    completionHandler(FetchResult(error: .parseError), nil)
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                completionHandler(FetchResult(error: .errorMessage(error.description)), nil)
            }
        })
    }
}
