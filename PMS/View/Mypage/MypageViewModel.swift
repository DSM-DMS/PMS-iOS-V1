//
//  MypageViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class MypageViewModel: ObservableObject {
    // Mypage
    @Published var nickname = "닉네임"
    @Published var plusScore = 0
    @Published var minusScore = 0
    @Published var status = "벌점 그만 쌓거라.."
    @Published var weekStatus = "잔류"
    @Published var isMeal = false
    
    // Password
    @Published var nowPassword = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var nowisHidden = false
    @Published var newisHidden = false
    @Published var confirmError = false
    @Published var errorMsg = ""
    @Published var passwordAlert = true
    
    // Logout
    @Published var logoutAlert = false
    
}
