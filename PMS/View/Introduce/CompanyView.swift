//
//  CompanyView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct CompanyView: View {
    @ObservedObject var introduceVM = IntroduceViewModel()
    @ObservedObject var NoticeDetailVM = NoticeDetailViewModel()
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        ScrollView {
            Text("자녀의 동아리")
            IntroduceRectangle()
            ForEach(1...10, id: \.self) { _ in
                IntroduceRectangle()
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CompanyView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            CompanyView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct IntroduceRectangle: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(width: UIFrame.UIWidth / 2 - 20, height: UIFrame.UIHeight / 4)
            VStack {
                Image("DMS")
                Text("DMS")
            }
        }
    }
}
