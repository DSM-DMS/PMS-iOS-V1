//
//  NoticeViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class NoticeViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var selectedIndex = 0
}
