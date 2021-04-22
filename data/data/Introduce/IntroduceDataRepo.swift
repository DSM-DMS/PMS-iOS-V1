//
//  IntroduceDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Combine

public class IntroduceDataRepo: IntroduceDomainRepoInterface {
    let introduceRemoteDataSource: IntroduceRemoteDataSourceInterface
    
    public init(introduceRemoteDataSource: IntroduceRemoteDataSourceInterface) {
        self.introduceRemoteDataSource = introduceRemoteDataSource
        
    }
    public func getClublist() -> AnyPublisher<ClubList, GEError> {
        return introduceRemoteDataSource.getClublist()
    }
    public func getClub(name: String) -> AnyPublisher<Club, GEError> {
        return introduceRemoteDataSource.getClub(name: name)
    }
}
