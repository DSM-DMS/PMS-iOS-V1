//
//  SignupView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var signupVM = SignupViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                TitleTextView(text: "회원가입")
                    .padding(.bottom, self.edges!.bottom == 0 ? 15 : 50)
                VStack(spacing: 20) {
                    CustomTextField(isLogin: false, text: self.$signupVM.nickname, placeholder: "닉네임을 입력해주세요", image: SFSymbolKey.pencil.rawValue, errorMsg: .constant(""))
                    CustomTextField(isLogin: false, text: self.$signupVM.nickname, placeholder: "아이디를 입력해주세요", image: SFSymbolKey.person.rawValue, errorMsg: .constant(""))
                    PasswordTextField(isLogin: false, text: self.$signupVM.password)
                    CheckTextField(text: self.$signupVM.id, isError: self.$signupVM.idError, placeholder: "비밀번호를 한번 더 입력해주세요", image: SFSymbolKey.circleCheck.rawValue, errorMsg: .constant(""))
                }
                OAuthView()
                ButtonView(text: "회원가입", color: "Red")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Image("NavArrow")
                })
            }
            .padding([.leading, .trailing], 30)
            VStack {
                Text("")
            }
        }.gesture(
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            SignupView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct CheckTextField: View {
    @Binding var text: String
    @Binding var isError: Bool
    var placeholder: String
    var image: String
    @Binding var errorMsg: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                if text != "" {
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("Red"))
                        .padding(.leading, 10)
                } else {
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.leading, 10)
                }
                TextField(placeholder, text: $text)
                Spacer()
                VStack {
                    if text != "" {
                        Image(systemName: SFSymbolKey.check.rawValue)
                            .resizable()
                            .frame(width: 17, height: 20)
                            .foregroundColor(isError ? .red : .green)
                    }
                }.padding(.trailing, 10)
                
            }
            
            if text != "" {
                Color("Red").frame(height: CGFloat(4) / UIScreen.main.scale)
            } else {
                Color.gray.frame(height: CGFloat(4) / UIScreen.main.scale)
            }
            HStack {
                Spacer()
                Text(errorMsg)
                    .foregroundColor(.red)
            }
        }
    }
}
