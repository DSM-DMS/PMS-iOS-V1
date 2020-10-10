//
//  IntroduceDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ClubDetailView: View {
    @ObservedObject var IntroduceDetailVM = IntroduceDetailViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 10) {
                CustomDivider()
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
                CustomDivider()
                Text("DMS")
                    .font(.title)
                    .fontWeight(.semibold)
                DetailIntroduce(title: "동아리 소개", text: self.IntroduceDetailVM.clubDesc)
                    .padding(.bottom)
                
                ClubMembersView(chief: self.IntroduceDetailVM.clubChief, members: self.IntroduceDetailVM.clubMembers)
                
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

struct ClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClubDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ClubDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct DetailIntroduce: View {
    var title: String
    var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(height: UIFrame.UIHeight / 10).shadow(radius: 5)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    BlueTabView()
                    Text(title)
                }
                
                Text(text)
                    .font(.callout)
                    .foregroundColor(Color.gray)
            }.padding([.leading, .trailing])
        }
    }
}

struct ClubMembersView: View {
    var chief: String
    var members: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(height: UIFrame.UIHeight / 3.5).shadow(radius: 5)
                
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Color("Blue").frame(width: 3, height: 20)
                    Text("동아리 인원")
                }.padding(.top, 10)
                VStack(alignment: .leading) {
                    HStack {
                        Text("부장 - ")
                        Text(chief)
                    }
                    HStack {
                        Text(members)
                    }
                }.foregroundColor(Color.gray)
                    .font(.callout)
                
            }.padding([.leading, .trailing])
        }
    }
}
