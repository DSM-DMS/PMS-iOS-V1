//
//  IntroduceRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Moya
import Combine

public protocol IntroduceRemoteDataSourceInterface {
    func getClublist() -> AnyPublisher<ClubList, GEError>
    func getClub(name: String) -> AnyPublisher<Club, GEError>
}

public class IntroduceRemoteDataSource: IntroduceRemoteDataSourceInterface {
    let provider: MoyaProvider<PMSApi>
    
    public init(provider: MoyaProvider<PMSApi> = MoyaProvider<PMSApi>()) {
        self.provider = provider
    }
    
    public func getClublist() -> AnyPublisher<ClubList, GEError> {
        provider.requestPublisher(.clubs)
            .map(ClubList.self)
            .mapError { error in
                mapGEEror(error)
            }.eraseToAnyPublisher()
    }
    
    public func getClub(name: String) -> AnyPublisher<Club, GEError> {
        provider.requestPublisher(.clubDetail(name))
            .map(Club.self)
            .mapError { error -> GEError in
                mapGEEror(error)
            }.eraseToAnyPublisher()
    }
    
}
