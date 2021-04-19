//
//  SuccessView.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/10.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct SuccessView: View {
    var text: String
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack {
                LottieView(filename: "success")
                    .frame(width: UIFrame.UIWidth / 5, height: UIFrame.UIWidth / 5)
                Text(text)
            }
            .padding().frame(width: UIFrame.UIWidth / 1.7, height: UIFrame.UIWidth / 2.5).background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
        }
        
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(text: "회원가입이 완료되었습니다.")
    }
}
