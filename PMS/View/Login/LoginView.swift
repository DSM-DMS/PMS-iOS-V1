//
//  LoginView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 40) {
                TitleTextView(text: "로그인")
                    .padding(.bottom, UIFrame.UIHeight / 10)
                
                VStack(alignment: .leading) {
                    VStack(spacing: 30) {
                        CustomTextField(text: self.$loginVM.id, placeholder: "아이디를 입력해주세요", image: "Person", errorMsg: .constant(""))
                        CustomTextField(text: self.$loginVM.id, placeholder: "비밀번호를 입력해주세요", image: "Lock", errorMsg: .constant(""))
                    }
                    HStack {
                        HStack(spacing: 10) {
                            if self.loginVM.isAuto {
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("Blue"))
                            } else {
                                Image(systemName: "checkmark.square")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                .foregroundColor(Color("Blue"))
                            }
                            Text("자동 로그인")
                        }.onTapGesture {
                            self.loginVM.isAuto.toggle()
                        }.padding(.leading, 10)
                        Spacer()
                    }
                    
                }
                OAuthView()
                
                ButtonView(text: "로그인", color: "Blue")
            }.padding(.leading, 30)
                .padding(.trailing, 30)
            //            .frame(width: UIFrame.UIWidth - 60)
            VStack {
                Text("")
            }
        }
        
    }
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var image: String
    @Binding var errorMsg: String
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack(spacing: 30) {
                Image(image)
                    .resizable()
                    .frame(width: 17, height: 20)
                    .padding(.leading, 10)
                TextField(placeholder, text: $text)
            }
            
            if text != "" {
                VStack {
                    Color("Purple").frame(height: CGFloat(4) / UIScreen.main.scale)
                }
            } else {
                VStack {
                    Color.gray.frame(height: CGFloat(4) / UIScreen.main.scale)
                }
            }
            HStack {
                Spacer()
                Text(errorMsg).foregroundColor(.red)
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            LoginView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct OAuthView: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("Facebook")
                .resizable()
                .frame(width: 70, height: 70)
            Image("Naver")
                .resizable()
                .frame(width: 70, height: 70)
            Image("KakaoTalk")
                .resizable()
                .frame(width: 70, height: 70)
            Image("Apple")
                .resizable()
                .frame(width: 70, height: 70)
        }
    }
}
