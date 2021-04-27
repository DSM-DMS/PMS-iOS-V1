//
//  GEEror+mapError.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Moya
import domain

func mapGEEror(_ error: MoyaError) -> GEError {
    if error.response?.statusCode == 401 {
        return GEError.unauthorized
    } else if error.response?.statusCode == 404 {
        return GEError.notFound
    } else if error.response?.statusCode == 403 {
        return GEError.forbidden
    } else if (error.errorDescription?.contains("인터넷 연결이 오프라인 상태입니다.")) != nil {
        return GEError.noInternet
    } else { return GEError.error }
}
