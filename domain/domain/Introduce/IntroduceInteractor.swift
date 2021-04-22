//
//  IntroduceInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Combine

public protocol IntroduceInteractorInterface {
    func getClublist() -> AnyPublisher<ClubList, GEError>
    func getClub(name: String) -> AnyPublisher<Club, GEError>
}

public class IntroduceInteractor: IntroduceInteractorInterface {
    
    let introduceDomainRepo: IntroduceDomainRepoInterface
    
    public init(introduceDomainRepo: IntroduceDomainRepoInterface) {
        self.introduceDomainRepo = introduceDomainRepo
    }
    
    public func getClublist() -> AnyPublisher<ClubList, GEError> {
        return introduceDomainRepo.getClublist()
    }
    
    public func getClub(name: String) -> AnyPublisher<Club, GEError> {
        return introduceDomainRepo.getClub(name: name)
    }
    
}
