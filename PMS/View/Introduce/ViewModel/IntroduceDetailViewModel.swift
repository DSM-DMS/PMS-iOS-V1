//
//  IntroduceDetailViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/10.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class IntroduceDetailViewModel: ObservableObject {
    @Published var desc: String = "대마고의 여러 시스템을 개발합니다"
    
    // Club
    @Published var chief: String = ""
    @Published var members: String =
    """
    1학년 - 정고은 정고은 정고은 정고은 정고은 정고은 정고은 정고은
    2학년 - 김도현 김도현 김도현 김도현 김도현 김도현 김도현 김도현
    3학년 - 이동기 이동기 이동기 이동기 이동기 이동기 이동기 이동기
    """
}
