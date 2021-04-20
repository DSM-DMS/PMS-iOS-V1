//
//  IntroduceDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain

public class IntroduceDataRepo: IntroduceDomainRepoInterface {
    let introduceRemoteDataSource: IntroduceRemoteDataSourceInterface
    
    public init(introduceRemoteDataSource: IntroduceRemoteDataSourceInterface) {
        self.introduceRemoteDataSource = introduceRemoteDataSource
        
    }
    
    public func getClublist(completion: @escaping (Result<ClubList, GEError>) -> Void) {
        introduceRemoteDataSource.getClublist { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getClub(name: String, completion: @escaping (Result<Club, GEError>) -> Void) {
        introduceRemoteDataSource.getClub(name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
