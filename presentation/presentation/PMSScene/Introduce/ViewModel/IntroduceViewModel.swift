//
//  IntroduceDetailViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Combine
import domain

public class IntroduceViewModel: ObservableObject {
    
    // MARK: Output
    
    @Published var clubList: ClubList = ClubList(clubs: [ClubDetail(name: "", imageUrl: "")])
    @Published var clubDetail: Club = Club(title: "", description: "", imageUrl: "", member: [""])
    
    @Published var companyDesc: String = "멋진 마이다스아이티입니다"
    @Published var companySite: String = "https://www.naver.com"
    @Published var companyAddress: String = "대전 유성구 장동 가정북로 76"
    
//    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    init() {
//        self.apiManager = APIManager()
        bindInputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    // MARK: Input
    
    enum Input {
        case getClubList
        case getClubDetail(name: String)
    }
    
    private let clubListSubject = PassthroughSubject<Void, Never>()
    private let clubDetailSubject = PassthroughSubject<String, Never>()
    
    func apply(_ input: Input) {
        switch input {
        case .getClubList:
            clubListSubject.send()
        case .getClubDetail(let name):
            clubDetailSubject.send(name)
        }
    }
    
    func bindInputs() {
        clubListSubject
            .compactMap { $0 }
            .sink(receiveValue: { _ in
                self.requestClubList()
            })
            .store(in: &bag)
        clubDetailSubject
            .compactMap { $0 }
            .sink(receiveValue: { name in
                self.requestClubDetail(name: name)
            })
            .store(in: &bag)
    }
    
    func openCompanySite() {
        guard let url = URL(string: self.companySite),
        UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}

extension IntroduceViewModel {
    func requestClubList() {
//        apiManager.getClubs()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    if error.response?.statusCode == 401 {
//                        AuthManager.shared.refreshToken()
//                        self.apply(.getClubList)
//                    }
////                    print(error)
//                }
//            }, receiveValue: { [weak self] clubs in
//                self?.clubList = clubs
//            })
//            .store(in: &bag)
    }
    
    func requestClubDetail(name: String) {
//        apiManager.getClubDetail(name: name)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    if error.response?.statusCode == 401 {
//                        AuthManager.shared.refreshToken()
//                        self.apply(.getClubDetail(name: name))
//                    }
////                    print(error)
//                }
//            }, receiveValue: { [weak self] club in
//                self?.clubDetail = club
//            })
//            .store(in: &bag)
    }
}
