//
//  NoticeInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Foundation
import Combine

public protocol NoticeInteractorInterface {
    func getNoticeList() -> AnyPublisher<[Notice], GEError>
    func getDetailNotice(id: Int) -> AnyPublisher<DetailNotice, GEError>
}

public class NoticeInteractor: NoticeInteractorInterface {
    let noticeDomainRepo: NoticeDomainRepoInterface
    
    public init(noticeDomainRepo: NoticeDomainRepoInterface) {
        self.noticeDomainRepo = noticeDomainRepo
    }
    
    public func getNoticeList() -> AnyPublisher<[Notice], GEError> {
        noticeDomainRepo.getNoticeList()
    }
    
    public func getDetailNotice(id: Int) -> AnyPublisher<DetailNotice, GEError> {
        noticeDomainRepo.getDetailNotice(id: id)
    }
}
