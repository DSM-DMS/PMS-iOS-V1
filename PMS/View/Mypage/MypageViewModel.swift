//
//  MypageViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine

class MypageViewModel: ObservableObject {
    // MARK: OUTPUT
    
    // Mypage
    @Published var nickname = "닉네임"
    @Published var plusScore = 0
    @Published var minusScore = 0
    @Published var status = "벌점 그만 쌓거라.."
    @Published var weekStatus = "잔류"
    @Published var isMeal = false
    @Published var newNickname = ""
    
    // Alert
    
    @Published var nicknameAlert = false
    @Published var studentCodeAlert = false
    @Published var studentsAlert = false
    @Published var deleteAlert = false
    @Published var logoutAlert = false
    @Published var showLoginModal = false
    
    // Password
    @Published var nowPassword = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var nowisHidden = true
    @Published var newisHidden = true
    @Published var confirmError = false
    @Published var errorMsg = ""
    @Published var passwordAlert = false
    @Published var confirmAlert = false
    
    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.apiManager = APIManager()
        bindInputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    enum Input {
        case onAppear
    }
    
    private let appearSubject = PassthroughSubject<Int, Never>()
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            appearSubject.send(1)
        }
    }
    
    func bindInputs() {
        appearSubject
            .compactMap { $0 }
            .sink(receiveValue: { num in
                self.requestStudent(number: num)
            })
            .store(in: &bag)
    }
}

extension MypageViewModel {
    func requestStudent(number: Int) {
        apiManager.mypage(number: number)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    if error.response?.statusCode == 404 {
                        // 학생이 사라짐.
                    }
                    print(error)
                }
            }, receiveValue: { [weak self] student in
//                self?.isSuccessAlert.toggle()
                self?.plusScore = student.plus
                self?.minusScore = student.minus
//                self?.weekStatus
                self?.isMeal = student.isMeal
            })
            .store(in: &bag)
    }
}
