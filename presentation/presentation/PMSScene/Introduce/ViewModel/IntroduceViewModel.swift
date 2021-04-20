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
    
    private var bag = Set<AnyCancellable>()
    
    private var introduceInteractor: IntroduceInteractorInterface
    private var authDataRepo: AuthDomainRepoInterface
    
    public init(introduceInteractor: IntroduceInteractorInterface, authDataRepo: AuthDomainRepoInterface) {
        self.introduceInteractor = introduceInteractor
        self.authDataRepo = authDataRepo
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
        introduceInteractor.getClublist { [weak self] result in
            switch result {
            case let .success(clubList):
                self?.clubList = clubList
            case let .failure(error):
                if error == .unauthorized {
                    self?.authDataRepo.refreshToken()
                    self?.requestClubList()
                }
            }
        }
    }
    
    func requestClubDetail(name: String) {
        introduceInteractor.getClub(name: name) { [weak self] result in
            switch result {
            case let .success(club):
                self?.clubDetail = club
            case let .failure(error):
                if error == .unauthorized {
                    self?.authDataRepo.refreshToken()
                    self?.requestClubDetail(name: name)
                }
            }
        }
    }
}
