//
//  MypageViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class MypageViewModel: ObservableObject {
    @Published var nickname = "닉네임"
    @Published var plusScore = 0
    @Published var minusScore = 0
    @Published var status = "벌점 그만 쌓거라.."
}
