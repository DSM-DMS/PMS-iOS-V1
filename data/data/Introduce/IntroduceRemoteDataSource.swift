//
//  IntroduceRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Moya

public protocol IntroduceRemoteDataSourceInterface {
    func getClublist(completion : @escaping (Result<ClubList, GEError>) -> Void)
    func getClub(name: String, completion: @escaping (Result<Club, GEError>) -> Void)
}

public class IntroduceRemoteDataSource: IntroduceRemoteDataSourceInterface {
    let provider: MoyaProvider<PMSApi>
    
    public init(provider: MoyaProvider<PMSApi> = MoyaProvider<PMSApi>()) {
        self.provider = provider
    }
    
    public func getClublist(completion: @escaping (Result<ClubList, GEError>) -> Void) {
        provider.request(.clubs) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let clubs = try JSONDecoder().decode(ClubList.self, from: responseData)
                    return completion(.success(clubs))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.errorCode == 6 {
                    return completion(.failure(GEError.noInternet))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func getClub(name: String, completion: @escaping (Result<Club, GEError>) -> Void) {
        provider.request(.clubDetail(name)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let club = try JSONDecoder().decode(Club.self, from: responseData)
                    return completion(.success(club))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.errorCode == 6 {
                    return completion(.failure(GEError.noInternet))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
}
