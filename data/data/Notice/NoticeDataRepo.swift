//
//  NoticeDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Foundation
import domain
import Combine

public class NoticeDataRepo: NoticeDomainRepoInterface {
    let noticeRemoteDataSource: NoticeRemoteDataSourceInterface
    
    public init(noticeRemoteDataSource: NoticeRemoteDataSourceInterface) {
        self.noticeRemoteDataSource = noticeRemoteDataSource
    }

    public func getNoticeList() -> AnyPublisher<[Notice], GEError> {
        noticeRemoteDataSource.getNoticeList()
    }
    
    public func getDetailNotice(id: Int) -> AnyPublisher<DetailNotice, GEError> {
        noticeRemoteDataSource.getDetailNotice(id: id)
    }
}
