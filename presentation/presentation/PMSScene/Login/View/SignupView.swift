//
//  SignupView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import domain

struct SignupView: View {
    @ObservedObject var signupVM = SignupViewModel()
    @EnvironmentObject var settings: LoginSettings
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
                        CustomTextField(isLogin: false, text: self.$signupVM.nickname, placeholder: "닉네임을 입력해주세요", image: "pencil-1")
                        CustomTextField(isLogin: false, text: self.$signupVM.id, placeholder: "이메일을 입력해주세요", image: "person")
                        PasswordTextField(isLogin: false, errorMsg: self.$signupVM.passwordErrorMsg, text: self.$signupVM.password, isHidden: self.$signupVM.isHidden)
                        CheckTextField(text: self.$signupVM.confirmPassword, isError: self.$signupVM.confirmIsError, placeholder: "비밀번호를 한번 더 입력해주세요", isChange: false, errorMsg: self.$signupVM.confirmErrorMsg)
                    }
                    OAuthView()
                    ButtonView(text: "회원가입", color: "Red")
                        .overlay(Color.white.opacity(signupVM.enableSignUp ? 0.0 : 0.5))
                        .onTapGesture {
                            if signupVM.enableSignUp {
                                signupVM.apply(.registerTapped)
                            }
                        }
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
            if self.signupVM.isErrorAlert {
                checkErrorView(text: "이메일 중복! 다른 이메일로 시도해주세요", isAlert: self.$signupVM.isErrorAlert)
            }
            
            if self.signupVM.isSuccessAlert {
                SuccessView(text: "회원가입이 완료되었습니다.")
                    .onAppear {
                        if UDManager.shared.isFirstView {
                            self.mode.wrappedValue.dismiss()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                            self.settings.isFirstView = true
                            UDManager.shared.isFirstView = true
                            UDManager.shared.isLogin = true
                        }
                    }
            }
        }.modifier(backDrag(offset: self.$offset))
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
                        Image("check")
                            .modifier(Template())
                            .frame(width: 20, height: 20)
                            .foregroundColor(isChange ? GEColor.blue : GEColor.red)
                            .padding(.leading, 10)
                    } else {
                        Image("check")
                            .modifier(Template())
                            .frame(width: 20, height: 20)
                            .padding(.leading, 10)
                    }
                }
                SecureField(placeholder, text: $text)
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
                Color(isChange ? GEEColor.blue.rawValue : GEEColor.red.rawValue)
                    .frame(height: CGFloat(4) / UIScreen.main.scale)
            } else {
                CustomDivider()
            }
            HStack {
                Spacer()
                Text(errorMsg)
                    .foregroundColor(.red)
            }
        }
    }
}
