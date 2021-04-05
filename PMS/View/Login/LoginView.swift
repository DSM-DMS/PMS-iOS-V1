//
//  LoginView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var settings: LoginSettings
    @ObservedObject var loginVM = LoginViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack(spacing: 40) {
                    TitleTextView(text: "로그인")
                        .padding(.bottom, UIFrame.UIHeight / 15)
                    
                    VStack(alignment: .leading) {
                        VStack(spacing: 30) {
                            CustomTextField(isLogin: true, text: self.$loginVM.id, placeholder: "아이디를 입력해주세요", image: "person")
                            PasswordTextField(isLogin: true, errorMsg: .constant(""), text: self.$loginVM.password, isHidden: self.$loginVM.isHidden)
                        }.padding(.bottom, 10)
                    }
                    
                    VStack {
                        OAuthView()
                        ButtonView(text: "로그인", color: "Blue")
                            .onTapGesture {
                                self.loginVM.apply(.loginTapped)
                            }
                    }
                }.padding([.leading, .trailing], 30)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Image("NavArrow")
                })
            }
            VStack {
                Text("")
            }
            if self.loginVM.isNotMatchError == true {
                checkErrorView(text: "아이디 또는 비밀번호가 일치하지 않습니다", isAlert: self.$loginVM.isNotMatchError)
            }
            if self.loginVM.isNotInternet == true {
                checkErrorView(text: "인터넷 연결이 되지 않았습니다.", isAlert: self.$loginVM.isNotInternet)
            }
            if self.loginVM.isSuccessAlert {
                SuccessView(text: "로그인이 완료되었습니다.")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                            self.settings.isFirstView = true
                            UDManager.shared.isFirstView = true
                            UDManager.shared.isLogin = true
                            if UDManager.shared.isFirstView {
                                self.mode.wrappedValue.dismiss()
                            }
                        }
                    }
            }
        }.modifier(backDrag(offset: self.$offset))
    }
}

struct CustomTextField: View {
    var isLogin: Bool
    @Binding var text: String
    var placeholder: String
    var image: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                if text != "" {
                    Image(image)
                        .modifier(Template())
                        .frame(width: 17, height: 20)
                        .padding(.leading, 10)
                        .foregroundColor(Color(isLogin ? "Blue" : "Red"))
                } else {
                    Image(image)
                        .modifier(Template())
                        .frame(width: 17, height: 20)
                        .padding(.leading, 10)
                }
                
                TextField(placeholder, text: $text)
            }
            
            if text != "" {
                Color(isLogin ? "Blue" : "Red").frame(height: CGFloat(4) / UIScreen.main.scale)
            } else {
                CustomDivider()
            }
        }
    }
}

struct PasswordTextField: View {
    var isLogin: Bool
    @Binding var errorMsg: String
    @Binding var text: String
    @Binding var isHidden: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                if text != "" {
                    Image("lock")
                        .modifier(Template())
                        .frame(width: 15, height: 20)
                        .foregroundColor(Color(isLogin ? "Blue" : "Red"))
                } else {
                    Image("lock")
                        .modifier(Template())
                        .frame(width: 15, height: 20)
                }
                
                if self.isHidden {
                    SecureField("비밀번호를 입력해주세요", text: $text)
                } else {
                    TextField("비밀번호를 입력해주세요", text: $text)
                }
                
                if text != "" {
                    Button(action: {
                        self.isHidden.toggle()
                    }) {
                        Image(systemName: "eye.fill")
                            .resizable()
                            .frame(width: 25, height: 15)
                            .foregroundColor(.gray)
                    }.padding(.trailing, 10)
                }
            }.padding(.leading, 10)
            
            if text != "" {
                VStack {
                    Color(isLogin ? "Blue" : "Red").frame(height: CGFloat(4) / UIScreen.main.scale)
                }
            } else {
                VStack {
                    CustomDivider()
                }
            }
            if errorMsg != "" {
                HStack {
                    Spacer()
                    Text(errorMsg)
                        .foregroundColor(.red)
                }
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

struct checkErrorView: View {
    var text: String
    @Binding var isAlert: Bool
    
    var body: some View {
        ZStack {
            Color(.black).opacity(0.3)
            VStack(spacing: 20) {
                Text(text)
                    .multilineTextAlignment(.center)
                    .frame(width: UIFrame.UIWidth / 2.5)
                    .padding(.top, 20)
                CustomDivider()
                Text("확인")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.isAlert = false
                    }
            }
            .padding()
            .frame(width: UIFrame.UIWidth - 80)
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
        }.edgesIgnoringSafeArea([.top, .bottom])
    }
}
