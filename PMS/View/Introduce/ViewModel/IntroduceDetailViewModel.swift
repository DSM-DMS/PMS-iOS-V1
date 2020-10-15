//
//  IntroduceDetailViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

class IntroduceDetailViewModel: ObservableObject {
    // Club
    @Published var clubDesc: String = "대마고의 여러 시스템을 개발합니다"
    
    @Published var clubChief: String = ""
    @Published var clubMembers: String =
    """
    1학년 - 정고은 정고은 정고은 정고은 정고은 정고은 정고은 정고은
    2학년 - 김도현 김도현 김도현 김도현 김도현 김도현 김도현 김도현
    3학년 - 이동기 이동기 이동기 이동기 이동기 이동기 이동기 이동기
    """
    
    @Published var companyDesc: String = "멋진 마이다스아이티입니다"
    @Published var companySite: String = "https://www.naver.com"
    @Published var companyAddress: String = "대전 유성구 장동 가정북로 76"
    
    func openCompanySite() {
        guard let url = URL(string: self.companySite),
        UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
