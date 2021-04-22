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
        bindOutputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    // MARK: Input
    
    enum Input {
        case getClubList
        case getClubDetail(name: String)
    }
    
    private let getClubListSubject = PassthroughSubject<Void, Never>()
    private let getClubDetailSubject = PassthroughSubject<String, Never>()
    private let clubListSubject = PassthroughSubject<ClubList, Never>()
    private let clubDetailSubject = PassthroughSubject<Club, Never>()
    private let errorSubject = PassthroughSubject<GEError, Never>()
    
    func apply(_ input: Input) {
        switch input {
        case .getClubList:
            getClubListSubject.send()
        case .getClubDetail(let name):
            getClubDetailSubject.send(name)
        }
    }
    
    func bindInputs() {
        getClubListSubject
            .flatMap { [introduceInteractor] _ in
                introduceInteractor.getClublist()
                    .catch { [weak self] error -> Empty<ClubList, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(clubListSubject)
            .store(in: &bag)
        
        getClubDetailSubject
            .flatMap { [introduceInteractor] name in
                introduceInteractor.getClub(name: name)
                    .catch { [weak self] error -> Empty<Club, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(clubDetailSubject)
            .store(in: &bag)
    }
    
    func bindOutputs() {
        clubListSubject
            .assign(to: \.clubList, on: self)
            .store(in: &bag)
        
        clubDetailSubject
            .assign(to: \.clubDetail, on: self)
            .store(in: &bag)
        
        errorSubject
            .sink(receiveValue: { [weak self] error in
                if error == .unauthorized {
                    self?.authDataRepo.refreshToken()
                    self?.apply(.getClubList)
                }
            })
    }
    
    func openCompanySite() {
        guard let url = URL(string: self.companySite),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
