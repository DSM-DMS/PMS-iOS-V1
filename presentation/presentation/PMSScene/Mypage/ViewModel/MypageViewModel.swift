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
import domain
// import Alamofire

public class MypageViewModel: ObservableObject {
    
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
    @Published var selectedStudent = ""
    
    // Alert
    @Published var nicknameAlert = false
    @Published var studentCodeAlert = false
    @Published var studentsAlert = false
    @Published var deleteAlert = false
    @Published var logoutAlert = false
    @Published var showLoginModal = false
    @Published var isNotInternet = false
    
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
    @Published var points = PointList(points: [Point]())
    @Published var outings = OutsideList(outings: [Outside]())
    
    // Student Add
    @Published var passCodeModel = studentCodeModel(passCodeLength: 6)
    @Published var attempts: Int = 0
    
    @Published var studentsArray = [String]()
    
    private var bag = Set<AnyCancellable>()
    
    private var mypageInteractor: MypageInteractorInterface
    private var authDataRepo: AuthDomainRepoInterface
    
    public init(mypageInteractor: MypageInteractorInterface, authDataRepo: AuthDomainRepoInterface) {
        self.mypageInteractor = mypageInteractor
        self.authDataRepo = authDataRepo
        bindInputs()
        bindOutputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    enum Input {
        case onAppear
        case addStudent
        case deleteStudent
        case changePassword
        case changeName
        case getPoint
        case getOutside
    }
    
    private let toGetStudentSubject = PassthroughSubject<Void, Never>()
    private let appearSubject = PassthroughSubject<Int, Never>()
    private let getStudentSubject = PassthroughSubject<User, Never>()
    private let addSubject = PassthroughSubject<Int, Never>()
    private let deleteSubject = PassthroughSubject<Int, Never>()
    private let changePasswordSubject = PassthroughSubject<Void, Never>()
    private let changeNameSubject = PassthroughSubject<Void, Never>()
    private let getPointSubject = PassthroughSubject<Int, Never>()
    private let getOutsideSubject = PassthroughSubject<Int, Never>()
    private let studentSubject = PassthroughSubject<Student, Never>()
    private let addeddStudentSubject = PassthroughSubject<Void, Never>()
    private let deletedStudentSubject = PassthroughSubject<Void, Never>()
    private let passwordErrorSubject = PassthroughSubject<Bool, Never>()
    private let passwordResponseSubject = PassthroughSubject<Void, Never>()
    private let errorSubject = PassthroughSubject<GEError, Never>()
    private let nameErrorSubject = PassthroughSubject<Bool, Never>()
    private let nameResponseSubject = PassthroughSubject<Void, Never>()
    private let PointSubject = PassthroughSubject<PointList, Never>()
    private let OutsideSubject = PassthroughSubject<OutsideList, Never>()
    
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
            toGetStudentSubject.send(())
            if checkDateForReset() == "03-01" {
                authDataRepo.resetStudent()
                self.currentStudent = UDManager.shared.currentStudent ?? ""
            }
            if UDManager.shared.currentStudent != nil {
                self.currentStudent = UDManager.shared.currentStudent ?? ""
                let str = UDManager.shared.currentStudent
                let arr =  str!.components(separatedBy: " ")
                appearSubject.send(Int(arr.first!)!)
            }
        case .addStudent:
            addSubject.send(Int(self.passCodeModel.passCodeString)!)
        case .deleteStudent:
            let arr =  self.selectedStudent.components(separatedBy: " ")
            deleteSubject.send(Int(arr.first!)!)
        case .changePassword:
            changePasswordSubject.send()
        case .getPoint:
            let str = UDManager.shared.currentStudent
            let arr =  str!.components(separatedBy: " ")
            getPointSubject.send(Int(arr.first!)!)
        case .getOutside:
            let str = UDManager.shared.currentStudent
            let arr =  str!.components(separatedBy: " ")
            getOutsideSubject.send(Int(arr.first!)!)
        case .changeName:
            changeNameSubject.send()
        }
    }
    
    func bindInputs() {
        toGetStudentSubject
            .flatMap { [authDataRepo] _ in
                authDataRepo.getStudent()
                    .catch { [weak self] error -> Empty<User, Never> in
                        print(error)
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(getStudentSubject)
            .store(in: &bag)
        
        appearSubject
            .flatMap { [mypageInteractor] number in
                mypageInteractor.mypage(number: number)
                    .catch { [weak self] error -> Empty<Student, Never> in
                        print(error)
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(studentSubject)
            .store(in: &bag)
        
        addSubject
            .flatMap { [mypageInteractor] number in
                mypageInteractor.addStudent(number: number)
                    .catch { [weak self] error -> Empty<Void, Never> in
                        self?.errorSubject.send(error)
                        if error != GEError.unauthorized {
                            withAnimation(.default) {
                                self?.attempts += 1
                            }
                        }
                        return .init()
                    }
            }.share()
            .subscribe(addeddStudentSubject)
            .store(in: &bag)
        
        deleteSubject
            .flatMap { [mypageInteractor] number in
                mypageInteractor.deleteStudent(number: number)
                    .catch { [weak self] error -> Empty<Void, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(deletedStudentSubject)
            .store(in: &bag)
        
        changePasswordSubject
            .flatMap { [mypageInteractor] _ in
                mypageInteractor.changePassword(password: self.newPassword, prePassword: self.nowPassword)
                    .catch { [weak self] error -> Empty<Void, Never> in
                        if error == GEError.unauthorized || error == GEError.noInternet {
                            self?.errorSubject.send(error)
                        } else {
                            self?.passwordErrorSubject.send(true)
                        }
                        return .init()
                    }
            }.share()
            .subscribe(passwordResponseSubject)
            .store(in: &bag)
        
        confirmPasswordValidPublisher
            .dropFirst()
            .sink { _confirmPasswordValidator in
                self.confirmError = _confirmPasswordValidator.confirmPasswordErrorMessage != nil
            }
            .store(in: &bag)
        
        changeNameSubject
            .flatMap { [mypageInteractor] _ in
                mypageInteractor.changeNickname(name: self.newNickname)
                    .catch { [weak self] error -> Empty<Void, Never> in
                        if error == GEError.unauthorized || error == GEError.noInternet {
                            self?.errorSubject.send(error)
                        } else {
                            self?.nameErrorSubject.send(true)
                        }
                        return .init()
                    }
            }.share()
            .subscribe(nameResponseSubject)
            .store(in: &bag)
        
        getPointSubject
            .flatMap { [mypageInteractor] number in
                mypageInteractor.getPointList(number: number)
                    .catch { [weak self] error -> Empty<PointList, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(PointSubject)
            .store(in: &bag)
        
        getOutsideSubject
            .flatMap { [mypageInteractor] number in
                mypageInteractor.getOutingList(number: number)
                    .catch { [weak self] error -> Empty<OutsideList, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(OutsideSubject)
            .store(in: &bag)
    }
    
    func bindOutputs() {
        getStudentSubject
            .sink { [weak self] result in
                var user = result
                user.students.sort { $0.number < $1.number }
                if UDManager.shared.currentStudent == nil && !user.students.isEmpty {
                    let firstuser: String = String(user.students.first!.number) + " " + user.students.first!.name
                    UDManager.shared.currentStudent = firstuser
                }
                var array = [String]()
                for student in user.students {
                    array.append(String((student.number)) + " " + (student.name))
                }
                self?.studentsArray = array
                print(array)
            }.store(in: &bag)
        
        studentSubject
            .sink { [weak self] student in
                self?.plusScore = student.plus
                self?.minusScore = student.minus
                self?.minusStatus(num: student.minus)
                self?.weekStatus = self?.convertStatus(num: student.status) ?? "오류가 났어요"
                self?.isMeal = student.isMeal
            }.store(in: &bag)
        
        addeddStudentSubject
            .sink { [weak self] _ in
                self?.studentCodeAlert = false
                self?.passCodeModel.selectedCellIndex = 0
                self?.apply(.onAppear)
            }.store(in: &bag)
        
        deletedStudentSubject
            .sink { [weak self] _ in
                var deletedArray = self?.studentsArray
                deletedArray = deletedArray!.filter { $0 != self?.selectedStudent }
                self?.studentsArray = deletedArray!
                
                if self?.selectedStudent == self?.currentStudent {
                    if !deletedArray!.isEmpty {
                        UDManager.shared.currentStudent = nil
                    } else {
                        self?.resetView()
                        UDManager.shared.currentStudent = nil
                    }
                    
                }
                self?.apply(.onAppear)
            }.store(in: &bag)
        
        passwordErrorSubject
            .assign(to: \.passwordAlert, on: self)
            .store(in: &bag)
        
        nameResponseSubject
            .sink { _ in
                UDManager.shared.name = self.newNickname
                self.nickname = self.newNickname
                self.nicknameAlert = false
            }.store(in: &bag)
        
        passwordResponseSubject
            .sink { _ in
                self.passwordSuccessAlert = true
            }.store(in: &bag)
        
        PointSubject
            .assign(to: \.points, on: self)
            .store(in: &bag)
        
        OutsideSubject
            .assign(to: \.outings, on: self)
            .store(in: &bag)
        
        errorSubject
            .sink(receiveValue: { error in
                if error == .unauthorized {
                    self.authDataRepo.refreshToken()
                    self.apply(.getPoint)
                }
            })
            .store(in: &bag)
        
        errorSubject
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { error in
                if error == .noInternet { print("NOO"); return true } else { return false }
            }
            .assign(to: \.isNotInternet, on: self)
            .store(in: &bag)
    }
}

extension MypageViewModel {

    func resetView() {
        self.plusScore = 0
        self.minusScore = 0
        self.currentStudent = ""
        self.status = "-"
    }
    
    func logout() {
        UDManager.shared.isLogin = false
        UDManager.shared.email = "test@test.com"
        UDManager.shared.password = "testpass"
        UDManager.shared.currentStudent = nil
        resetView()
        authDataRepo.refreshToken()
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
        if !UDManager.shared.isLogin {
            self.status = "-"
        } else if num < 5 {
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
