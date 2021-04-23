//
//  NoticeDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Foundation
import Combine

public protocol NoticeDomainRepoInterface {
    func getNoticeList() -> AnyPublisher<[Notice], GEError>
    func getDetailNotice(id: Int) -> AnyPublisher<DetailNotice, GEError>
}
