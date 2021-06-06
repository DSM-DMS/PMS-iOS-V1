//
//  Validation.swift
//  presentation
//
//  Created by GoEun Jeong on 2021/04/27.
//

import Foundation

func passwordStrengthChecker(forPassword text: String) -> PasswordValidation {
    let entropy = text.count
    if entropy < 4 {
        return .veryWeak
    } else if entropy < 6 {
        return .weak
    } else if entropy < 8 {
        return .reasonable
    } else if entropy < 10 {
        return .strong
    } else {
        return .veryStrong
    }
}

public enum PasswordValidation {
    case veryWeak
    case weak
    case reasonable
    case strong
    case veryStrong

    case empty
    case confirmPasswordEmpty
    case notMatch

    var errorMessage: String? {
        switch self {
        case .veryWeak:
            return "비밀번호가 약합니다."
        case .weak:
            return "비밀번호가 약합니다."
        case .empty:
            return "비밀번호를 입력해주세요."
         default:
            return nil
        }
    }

    var confirmPasswordErrorMessage: String? {
        switch self {
        case .confirmPasswordEmpty:
            return "확인할 비밀번호를 입력해주세요."
        case .notMatch:
            return "비밀번호가 일치하지 않습니다."
        default:
            return nil
        }
    }
}

public enum EmailValidation {
    case emptyEmail
    case inValidEmail
    case validEmail
    var errorMessage: String? {
        switch self {
        case .emptyEmail:
            return "이메일을 입력해주세요."
        case .inValidEmail:
            return "이메일 형식이 아닙니다."
        case .validEmail:
            return nil
        }
    }
}
