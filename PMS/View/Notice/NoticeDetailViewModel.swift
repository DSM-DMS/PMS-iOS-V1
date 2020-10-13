//
//  NoticeDetailViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/09.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

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
    
    @Published var pdfAlert = false
    @Published var pdfTitle = "가정통신문.pdf"
    
    let pdfUrl = Bundle.main.url(forResource: "testPdf", withExtension: "pdf")!
    
    func downloadFile(fileName: String) {
        let fileManager = FileManager.default
        
        let documentsURL = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            if !fileManager.fileExists(atPath: fileURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "testPdf", ofType: "pdf") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: fileURL.path)
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(fileURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }

    }
}
