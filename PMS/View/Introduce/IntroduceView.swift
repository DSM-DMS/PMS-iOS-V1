//
//  IntroduceView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct IntroduceView: View {
    var body: some View {
        NavigationView {
            GeometryReader { _ in
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        TitleTextView(text: "소개")
                        Text("대마고의 자랑거리를 소개합니다")
                            .foregroundColor(Color("Blue"))
                    }.padding(.bottom, UIFrame.UIHeight / 15)
                    
                    VStack(spacing: UIFrame.UIHeight / 15) {
                        NavigationLink(destination: ClubView()) {
                            RectangleView(title: "동아리 소개", sub: "대마고의 동아리를 소개합니다")
                        }
                        NavigationLink(destination: CompanyView()) {
                            RectangleView(title: "취업처 소개", sub: "대마고의 학생들이 취업한 회사를 소개합니다")
                        }
                        NavigationLink(destination: DeveloperView()) {
                            RectangleView(title: "개발자 소개", sub: "PMS의 개발자를 소개합니다")
                        }
                    }
                }.padding(.leading, 30)
                .padding(.trailing, 30)
                VStack {
                    Text("")
                }
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct IntroduceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IntroduceView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            IntroduceView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct RectangleView: View {
    var title: String
    var sub: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray")).frame(width: UIFrame.UIWidth - 60, height: UIFrame.UIWidth / 4)
                .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 3)
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Color("Blue").frame(width: 3, height: 18)
                        Text(title)
                            .foregroundColor(.black)
                    }
                    Text(sub)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding(.leading, 20)
            
        }
    }
}
