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
    @Published var status = "-"
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
            self.nickname = UDManager.shared.name ?? "UD가 비어있음"
            if checkDateForReset() == "03-01" {
                AuthManager.shared.requestStudent()
            }
            if UDManager.shared.currentStudent == nil {
                
            } else {
                let str = UDManager.shared.currentStudent
                let arr =  str!.components(separatedBy: " ")
                appearSubject.send(Int(arr.first!)!)
            }
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
            .retry(2)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                    } else if error.response?.statusCode == 404 {
                        let arr = UDManager.shared.studentsArray
                        UDManager.shared.currentStudent = arr?.first as? String
                    }
                    print(error)
                }
            }, receiveValue: { [weak self] student in
                self?.plusScore = student.plus
                self?.minusScore = student.minus
                self?.minusStatus(num: student.minus)
                self?.weekStatus = self?.convertStatus(num: student.status) ?? "오류가 났어요"
                self?.isMeal = student.isMeal
            })
            .store(in: &bag)
    }
    
    func convertStatus(num: Int) -> String {
        if num == 1 {
            return "금요귀가"
        } else if num == 2 {
            return "토요귀가"
        } else if num == 3 {
            return "토요귀사"
        } else if num == 4 {
            return "잔류"
        } else {
            return "오류가 났어요"
        }
    }
    
    func minusStatus(num: Int) {
        if num < 5 {
            self.status = "혹시 신입생이신가요?"
        } else if num >= 5 && num < 10 {
            self.status = "꽤 모범적이에요!"
        } else if num >= 10 && num < 15 {
            self.status = "관리가 필요해요~"
        } else if num >= 15 && num < 20 {
            self.status = "1차 봉사를  축하드립니다."
        } else if num >= 20 && num < 25 {
            self.status = "2차 봉사를 축하드립니다."
        } else if num >= 25 && num < 30 {
            self.status = "벌점을 줄여주세요!!"
        } else if num >= 30 && num < 35 {
            self.status = "3차 봉사를 축하드립니다."
        } else if num >= 35 && num < 40 {
            self.status = "퇴사를 당하고 싶으신가요?"
        } else if num <= 40 {
            self.status = "......"
        }
    }
    
    func checkDateForReset() -> String {
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
