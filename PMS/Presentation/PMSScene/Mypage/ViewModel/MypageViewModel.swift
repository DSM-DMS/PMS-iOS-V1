//
//  MypageViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class MypageViewModel: ObservableObject {
    
    // MARK: OUTPUT
    // Mypage
    @Published var nickname = UDManager.shared.name ?? "닉네임"
    @Published var currentStudent = UDManager.shared.currentStudent ?? "학생추가"
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
    @Published var passwordSuccessAlert = false
    
    // Point List & Outing List
    @Published var points: PointList?
    @Published var outings: OutsideList?
    
    // Student Add
    @Published var passCodeModel = studentCodeModel(passCodeLength: 6)
    @Published var attempts: Int = 0
    
    @Published var studentsArray = [String]()
    
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
        case addStudent
        case changePassword
        case changeName
        case getPoint
        case getOutside
    }
    
    private let appearSubject = PassthroughSubject<Int, Never>()
    private let addSubject = PassthroughSubject<Int, Never>()
    private let passwordSubject = PassthroughSubject<Void, Never>()
    private let nameSubject = PassthroughSubject<Void, Never>()
    private let pointSubject = PassthroughSubject<Int, Never>()
    private let outsideSubject = PassthroughSubject<Int, Never>()
    
    private var confirmPasswordValidPublisher: AnyPublisher<PasswordValidation, Never> {
        $confirmPassword
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { confirmPassword in
                if confirmPassword.isEmpty {
                    return .confirmPasswordEmpty
                } else if self.newPassword != confirmPassword {
                    return .notMatch
                } else {
                    return .reasonable
                }
        }
        .eraseToAnyPublisher()
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            if checkDateForReset() == "03-01" {
                AuthManager.shared.requestStudent()
                // 로직 더 추가해야됨... 학번 리셋 코드
            }
            if UDManager.shared.currentStudent == nil {
                AuthManager.shared.requestStudent()
                if UDManager.shared.currentStudent != nil {
                    let str = UDManager.shared.currentStudent
                    self.currentStudent = UDManager.shared.currentStudent!
                    let arr =  str!.components(separatedBy: " ")
                    appearSubject.send(Int(arr.first!)!)
                }
            } else {
                if studentsArray.isEmpty {
                    studentsArray = UDManager.shared.studentsArray!
                }
                let str = UDManager.shared.currentStudent
                self.currentStudent = UDManager.shared.currentStudent!
                let arr =  str!.components(separatedBy: " ")
                appearSubject.send(Int(arr.first!)!)
            }
        case .addStudent:
            addSubject.send(Int(self.passCodeModel.passCodeString)!)
        case .changePassword:
            passwordSubject.send()
        case .getPoint:
            let str = UDManager.shared.currentStudent
            let arr =  str!.components(separatedBy: " ")
            pointSubject.send(Int(arr.first!)!)
        case .getOutside:
            let str = UDManager.shared.currentStudent
            let arr =  str!.components(separatedBy: " ")
            outsideSubject.send(Int(arr.first!)!)
        case .changeName:
            nameSubject.send()
        }
    }
    
    func bindInputs() {
        appearSubject
            .compactMap { $0 }
            .sink(receiveValue: { num in
                self.requestStudent(number: num)
            })
            .store(in: &bag)
        
        addSubject
            .compactMap { $0 }
            .sink(receiveValue: { num in
                self.addStudent(number: num)
            })
            .store(in: &bag)
        
        passwordSubject
            .compactMap { $0 }
            .sink(receiveValue: { _ in
                self.changePassword(password: self.newPassword, prePassword: self.nowPassword)
            })
            .store(in: &bag)
        
        confirmPasswordValidPublisher
            .dropFirst()
            .sink { (_confirmPasswordValidator) in
                self.confirmError = _confirmPasswordValidator.confirmPasswordErrorMessage != nil
        }
        .store(in: &bag)
        
        nameSubject
            .compactMap { $0 }
            .sink(receiveValue: { _ in
                self.changeNickname(name: self.newNickname)
            })
            .store(in: &bag)
        
        pointSubject
            .compactMap { $0 }
            .sink(receiveValue: { num in
                self.getPointList(number: num)
            })
            .store(in: &bag)
        
        outsideSubject
            .compactMap { $0 }
            .sink(receiveValue: { num in
                self.getOutingList(number: num)
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
                        UDManager.shared.currentStudent = arr?.first
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
    
    func changeNickname(name: String) {
        apiManager.changeName(name: name)
            .receive(on: DispatchQueue.main)
            .retry(2)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                    }
                    print(error)
                }
                if case .finished = completion {
                    UDManager.shared.name = name
                    self?.nickname = name
                }
            }, receiveValue: { _ in })
            .store(in: &bag)
    }
    
    func changePassword(password: String, prePassword: String) {
        apiManager.changePassword(password: password, prePassword: prePassword)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                        self?.apply(.changePassword)
                    }
                    self?.passwordAlert.toggle()
                    print(error)
                }
                if case .finished = completion {
                    UDManager.shared.password = password
                    self?.passwordSuccessAlert.toggle()
                }
            }, receiveValue: { _ in })
            .store(in: &bag)
    }
    
    func addStudent(number: Int) {
        apiManager.addStudent(number: number)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                    } else if error.response?.statusCode == 404 {
                        withAnimation(.default) {
                            self?.attempts += 1
                        }
                        // 그런 학생은 없습니다.
                    }
                    self?.passwordAlert.toggle()
                    print(error)
                }
                if case .finished = completion {
                    self?.studentCodeAlert = false
                    self?.passCodeModel.selectedCellIndex = 0
                    AuthManager.shared.requestStudent()
                    self?.studentsArray = UDManager.shared.studentsArray!
                    // currentStudent 바꾸고 음.. 학생 목록 업데이트해야됨
                }
            }, receiveValue: { _ in })
            .store(in: &bag)
    }
    
    func getPointList(number: Int) {
        apiManager.getPointList(number: number)
            .receive(on: DispatchQueue.main)
            .retry(2)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                    } else if error.response?.statusCode == 404 {
                        // 그런 학생은 없습니다.
                    }
                    print(error)
                }
            }, receiveValue: { [weak self] pointList in
                self?.points = pointList
            })
            .store(in: &bag)
    }
    
    func getOutingList(number: Int) {
        apiManager.getOutsideList(number: number)
            .receive(on: DispatchQueue.main)
            .retry(2)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                    } else if error.response?.statusCode == 404 {
                        // 그런 학생은 없습니다.
                    }
                    print(error)
                }
            }, receiveValue: { [weak self] outingList in
                self?.outings = outingList
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
            self.status = "아직 3월달인가요?"
        } else if num >= 5 && num < 10 {
            self.status = "꽤 모범적이네요!"
        } else if num >= 10 && num < 15 {
            self.status = "1차 봉사는 하셨나요?"
        } else if num >= 15 && num < 20 {
            self.status = "2차 봉사는 하셨나요?"
        } else if num >= 20 && num < 25 {
            self.status = "3차 봉사는 하셨나요?"
        } else if num >= 25 && num < 30 {
            self.status = "벌점을 줄여주세요!!"
        } else if num >= 30 && num < 35 {
            self.status = "곧 다벌점 교육이..."
        } else if num >= 35 && num < 40 {
            self.status = "이정도면 퇴사를 당하고 싶으신가요?"
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
