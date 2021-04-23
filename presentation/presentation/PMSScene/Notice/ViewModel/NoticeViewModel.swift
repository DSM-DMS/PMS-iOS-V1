//
//  NoticeViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine
import domain

public class NoticeViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var selectedIndex = 0
    @Published var notices = [Notice]()
    @Published var noticeDetail = DetailNotice(id: 0, date: "", title: "", body: "", comment: [Comment]())
    @Published var myComment = ""
    @Published var personSearch = ""
    @Published var pdfAlert = false
    @Published var pdfTitle = "가정통신문.pdf"
    
    private var bag = Set<AnyCancellable>()
    
    private var noticeInteractor: NoticeInteractor
    private var authDataRepo: AuthDomainRepoInterface
    
    public init(noticeInteractor: NoticeInteractor, authDataRepo: AuthDomainRepoInterface) {
        self.noticeInteractor = noticeInteractor
        self.authDataRepo = authDataRepo
        bindInputs()
        bindOutputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    enum Input {
        case getNotice
        case getNoticeDetail(id: Int)
    }
    
    private let getNoticeSubject = PassthroughSubject<Void, Never>()
    private let getNoticeDetailSubject = PassthroughSubject<Int, Never>()
    private let noticeListSubject = PassthroughSubject<[Notice], Never>()
    private let noticeSubject = PassthroughSubject<DetailNotice, Never>()
    
    func apply(_ input: Input) {
        switch input {
        case .getNotice:
            getNoticeSubject.send(())
        case let .getNoticeDetail(id: id):
            getNoticeDetailSubject.send(id)
        }
    }
    
    func bindInputs() {
        getNoticeSubject
            .flatMap { [noticeInteractor] _ in
                noticeInteractor.getNoticeList()
                    .catch { [weak self] error -> Empty<[Notice], Never> in
                        if error == GEError.unauthorized {
                            self?.authDataRepo.refreshToken()
                            self?.apply(.getNotice)
                        }
                        return .init()
                    }
            }.share()
            .subscribe(noticeListSubject)
            .store(in: &bag)
        
        getNoticeDetailSubject
            .flatMap { [noticeInteractor] id in
                noticeInteractor.getDetailNotice(id: id)
                    .catch { [weak self] error -> Empty<DetailNotice, Never> in
                        if error == GEError.unauthorized {
                            self?.authDataRepo.refreshToken()
                            self?.apply(.getNoticeDetail(id: id))
                        }
                        return .init()
                    }
            }.share()
            .subscribe(noticeSubject)
            .store(in: &bag)
            
    }
    
    func bindOutputs() {
        noticeListSubject
            .assign(to: \.notices, on: self)
            .store(in: &bag)
        
        noticeSubject
            .assign(to: \.noticeDetail, on: self)
            .store(in: &bag)
    }
    
}

extension NoticeViewModel {
    //    let pdfUrl = Bundle.main.url(forResource: "testPdf", withExtension: "pdf")!
    
    func downloadFile(fileName: String) {
        let fileManager = FileManager.default
        
        let documentsURL = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            if !fileManager.fileExists(atPath: fileURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "testPdf", ofType: "pdf") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: fileURL.path)
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(fileURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
        
    }
}
