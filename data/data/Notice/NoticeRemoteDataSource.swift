//
//  NoticeRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Foundation
import domain
import Moya
import Combine

public protocol NoticeRemoteDataSourceInterface {
    func getNoticeList() -> AnyPublisher<[Notice], GEError>
    func getDetailNotice(id: Int) -> AnyPublisher<DetailNotice, GEError>
}

public class NoticeRemoteDataSource: NoticeRemoteDataSourceInterface {
    let provider: MoyaProvider<PMSApi>
    
    public init(provider: MoyaProvider<PMSApi> = MoyaProvider<PMSApi>()) {
        self.provider = provider
    }
    
    public func getNoticeList() -> AnyPublisher<[Notice], GEError> {
        provider.requestPublisher(.notice)
            .map([Notice].self)
            .mapError { error in
                mapGEEror(error)
            }.eraseToAnyPublisher()
    }
    
    public func getDetailNotice(id: Int) -> AnyPublisher<DetailNotice, GEError> {
        provider.requestPublisher(.noticeDetail(id))
            .map(DetailNotice.self)
            .mapError { error in
                print(error)
                return mapGEEror(error)
            }.eraseToAnyPublisher()
    }
}
