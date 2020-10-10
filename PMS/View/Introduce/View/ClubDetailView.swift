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
    var body: some View {
        VStack {
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
            DetailIntroduce(title: "동아리 소개", text: self.IntroduceDetailVM.desc)
            
            ClubMembersView(chief: self.IntroduceDetailVM.chief, members: self.IntroduceDetailVM.members)
            
        }.padding([.leading, .trailing], 30)
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
                    Color("Blue").frame(width: 3, height: 20)
                    Text(title)
                }
                
                Text(text)
                    .foregroundColor(Color.gray)
            }.padding([.leading, .trailing])
        }
    }
}

struct ClubMembersView: View {
    var chief: String
    var members: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(height: UIFrame.UIHeight / 10).shadow(radius: 5)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Color("Blue").frame(width: 3, height: 20)
                    Text("동아리 인원")
                }
                VStack {
                    HStack {
                        Text("부장 - ")
                        Text(chief)
                    }
                    HStack {
                        Text(members)
                    }
                }.foregroundColor(Color.gray)
                
                
            }.padding([.leading, .trailing])
        }
    }
}
