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
            ZStack {
                VStack {
                    TitleTextView(text: "회원가입")
                        .padding(.bottom, self.edges!.bottom == 0 ? 15 : 50)
                    VStack(spacing: 30) {
                        CustomTextField(isLogin: false, text: self.$signupVM.nickname, placeholder: "닉네임을 입력해주세요", image: SFSymbolKey.pencil.rawValue)
                        CustomTextField(isLogin: false, text: self.$signupVM.id, placeholder: "아이디를 입력해주세요", image: SFSymbolKey.person.rawValue)
                        PasswordTextField(isLogin: false, text: self.$signupVM.password, isHidden: self.$signupVM.isHidden)
//                        CheckTextField(text: self.$signupVM.confirmPassword, isError: self.$signupVM.confirmIsError, placeholder: "비밀번호를 한번 더 입력해주세요", isChange: false, errorMsg: self.$signupVM.confirmErrorMsg)
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
            }
            VStack {
                Text("")
            }
            if self.signupVM.isAlert == true {
                checkErrorView(text: "아이디 또는 비밀번호가 일치하지 않습니다", isAlert: self.$signupVM.isAlert)
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
    var isChange: Bool
    @Binding var errorMsg: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                if !isChange {
                    if text != "" {
                        Image(systemName: SFSymbolKey.circleCheck.rawValue)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(isChange ? "Blue" : "Red"))
                            .padding(.leading, 10)
                    } else {
                        Image(systemName: SFSymbolKey.circleCheck.rawValue)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 10)
                    }
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
