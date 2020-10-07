//
//  MypageView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct MypageView: View {
    @ObservedObject var mypageVM = MypageViewModel()
    var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack {
                    Color("Blue").frame(height: UIFrame.UIHeight / 4)
                }.edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 20) {
                    MypageTopView(nickname: self.mypageVM.nicknamMypageVMe)
                    
                    TwoScoreView(plus: self.$mypageVM.plusScore, minus: self.$mypageVM.minusScore)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30).foregroundColor(Color("Blue")).frame(height: UIFrame.UIWidth / 10)
                        Text(self.mypageVM.status)
                            .foregroundColor(.white)
                    }
                    
                }.padding([.leading, .trailing])
            }
            VStack {
                Text("")
            }
        }
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MypageView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            MypageView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct ScoreView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray")).shadow(radius: 10).frame(width: UIFrame.UIWidth / 2 - 50, height: UIFrame.UIHeight / 10)
    }
}

struct TwoScoreView: View {
    @Binding var plus: String
    @Binding var minus: String
    var body: some View {
        HStack(spacing: 30) {
            ZStack {
                ScoreView()
                VStack {
                    Text(plus)
                        .font(.title)
                    Text("상점")
                        .foregroundColor(.red)
                }
            }
            ZStack {
                ScoreView()
                VStack {
                    Text(minus)
                        .font(.title)
                    Text("벌점")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct MypageTopView: View {
    var nickname: String
    var body: some View {
        HStack {
            Text(nickname)
                .font(.title)
                .foregroundColor(.white)
            Image("Pencil")
            Spacer()
            Text("학생추가")
                .font(.headline)
                .foregroundColor(.white)
            Image("BottomArrow")
        }.padding(.bottom, 20)
            .padding([.leading, .trailing], 30)
    }
}
