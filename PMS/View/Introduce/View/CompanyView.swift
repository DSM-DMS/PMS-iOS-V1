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
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ScrollView {            
            ForEach(1...10, id: \.self) { _ in
                HStack(spacing: 20) {
                    NavigationLink(destination: CompanyDetailView()) {
                        IntroduceRectangle(image: "DMS", text: "마이다스아이티")
                    }
                    NavigationLink(destination: CompanyDetailView()) {
                        IntroduceRectangle(image: "DMS", text: "마이다스아이티")
                    }
                }.padding(.bottom)
            }.padding([.leading, .trailing], 30)
            .padding([.top, .bottom], 10)
        }.navigationBarTitle("취업처 소개", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image("NavArrow")
            })
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                        if abs(self.offset.width) > 0 {
                            self.mode.wrappedValue.dismiss()
                        }
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 0 {
                        self.mode.wrappedValue.dismiss()
                    } else {
                        self.offset = .zero
                    }
                }
        )
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
