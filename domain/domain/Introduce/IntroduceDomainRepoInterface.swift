//
//  IntroduceDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol IntroduceDomainRepoInterface {
    func getClublist(completion : @escaping (Result<ClubList, GEError>) -> Void)
    func getClub(name: String, completion: @escaping (Result<Club, GEError>) -> Void)
}
