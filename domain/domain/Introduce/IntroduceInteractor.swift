//
//  IntroduceInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol IntroduceInteractorInterface {
    func getClublist(completion : @escaping (Result<ClubList, GEError>) -> Void)
    func getClub(name: String, completion: @escaping (Result<Club, GEError>) -> Void)
}

public class IntroduceInteractor: IntroduceInteractorInterface {
    let introduceDomainRepo: IntroduceDomainRepoInterface
    
    public init(introduceDomainRepo: IntroduceDomainRepoInterface) {
        self.introduceDomainRepo = introduceDomainRepo
    }
    
    public func getClublist(completion: @escaping (Result<ClubList, GEError>) -> Void) {
        introduceDomainRepo.getClublist { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getClub(name: String, completion: @escaping (Result<Club, GEError>) -> Void) {
        introduceDomainRepo.getClub(name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
