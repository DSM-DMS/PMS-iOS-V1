//
//  ClubView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ClubView: View {
    @ObservedObject var introduceVM = IntroduceViewModel()
    @ObservedObject var NoticeDetailVM = NoticeDetailViewModel()
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClubView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ClubView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
