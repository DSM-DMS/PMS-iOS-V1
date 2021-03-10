//
//  APIManager.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/09.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine
import Moya

class APIManager {
    let provider = MoyaProvider<PMSApi>()
    
    func login(email: String, password: String) -> AnyPublisher<Success, MoyaError> {
        provider.requestPublisher(.login(email: email, password: password))
            .map(Success.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func regiser(email: String, password: String, name: String) -> AnyPublisher<Success, MoyaError> {
        provider.requestPublisher(.register(email: email, password: password, name: name))
            .map(Success.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    //    func load() {
    //        let provider = MoyaProvider<PostService>()
    //        provider.request(.getPosts) { result in
    //            switch result {
    //            case let .success(moyaResponse):
    //                do {
    //                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
    //                    let posts = try filteredResponse.map([Post].self)
    //                    self.posts = posts
    //                    self.objectWillChange.send()
    //                } catch let error {
    //                     print("Error: \(error)")
    //                }
    //            case let .failure(error):
    //                print("Error: \(error)")
    //            }
    //        }
    //    }
}
