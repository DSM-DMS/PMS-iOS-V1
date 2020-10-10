//
//  MealViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var today = "2020/09/21"
    @Published var now = "점심"
    @Published var meal =
    """
    현미밥
    들깨수제비국
    목살고추장구이
    깻잎
    쌈무
    첨포묵김가루무침
    배추김치
    오렌지
    """
    @Published var isPicture = false
}
