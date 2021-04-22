//
//  IntroduceDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import Combine

public protocol IntroduceDomainRepoInterface {
    func getClublist() -> AnyPublisher<ClubList, GEError>
    func getClub(name: String) -> AnyPublisher<Club, GEError>
}
