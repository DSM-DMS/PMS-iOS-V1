//
//  CompanyDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct CompanyDetailView: View {
    @ObservedObject var IntroduceDetailVM = IntroduceViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 10) {
                Color.gray.frame(height: 2)
                ZStack {
                    Rectangle().frame(height: UIFrame.UIHeight / 4)
                    Rectangle().frame(height: UIFrame.UIHeight / 4)
                }
                
                HStack {
                    ImageCircle()
                    ImageCircle()
                    ImageCircle()
                    ImageCircle()
                    ImageCircle()
                }
                Color.gray.frame(height: 2)
                Text("DMS")
                    .font(.title)
                    .fontWeight(.semibold)
                VStack(spacing: 20) {
                    DetailIntroduce(title: "회사 소개", text: self.IntroduceDetailVM.companyDesc)
                    
                    CompanySiteView(title: "회사 사이트 바로가기", address: self.IntroduceDetailVM.companyAddress).onTapGesture {
                        self.IntroduceDetailVM.openCompanySite()
                    }
                    
                    DetailIntroduce(title: "회사 주소", text: self.IntroduceDetailVM.companyAddress)
                }
                
            }.padding(.top, 10)
            VStack {
                Text("")
            }
        }.padding([.leading, .trailing], 30)
            .navigationBarTitle("DMS", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image("NavArrow")
            })
        .modifier(backDrag(offset: self.$offset))
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CompanyDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            CompanyDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct CompanySiteView: View {
    var title: String
    var address: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIHeight / 15).shadow(radius: 5)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    BlueTabView()
                    Text(title)
                }
            }.padding([.leading, .trailing])
        }
    }
}

struct BlueTabView: View {
    var body: some View {
        GEColor.blue.frame(width: 3, height: 17)
    }
}

struct RedTabView: View {
    var body: some View {
        GEColor.red.frame(width: 3, height: 17)
    }
}
