//
//  Validation.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
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
            return "Vary weak password"
        case .weak:
            return "Weak password"
        case .empty:
            return "Please enter password"
         default:
            return nil
        }
    }

    var confirmPasswordErrorMessage: String? {
        switch self {
        case .confirmPasswordEmpty:
            return "확인할 비밀번호를 입력해주세요"
        case .notMatch:
            return "비밀번호가 일치하지 않습니다."
        default:
            return nil
        }
    }
}
