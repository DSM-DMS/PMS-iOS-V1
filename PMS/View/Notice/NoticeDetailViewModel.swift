//
//  NoticeDetailViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/09.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class NoticeDetailViewModel: ObservableObject {
    @Published var noticeTitle: String = ""
    @Published var noticeDesc: String = """
정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애
점심나가서먹을꺼같애점심나가서먹을꺼같애점심나가서먹을꺼같애
정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애
점심나가서먹을꺼같애점심나가서먹을꺼같애점심나가서먹을꺼같애
정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애
점심나가서먹을꺼같애점심나가서먹을꺼같애점심나가서먹을꺼같애
정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애
점심나가서먹을꺼같애점심나가서먹을꺼같애점심나가서먹을꺼같애
정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애
점심나가서먹을꺼같애점심나가서먹을꺼같애점심나가서먹을꺼같애
정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애정신나갈꺼같애
점심나가서먹을꺼같애점심나가서먹을꺼같애점심나가서먹을꺼같애
"""
    @Published var comment = ""
    @Published var personSearch = ""
}
