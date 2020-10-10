//
//  LoginViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var id = ""
    @Published var password = ""
    @Published var isAuto = false
    @Published var isHidden = true
    @Published var errorMsg = ""
    @Published var isAlert = true
}
