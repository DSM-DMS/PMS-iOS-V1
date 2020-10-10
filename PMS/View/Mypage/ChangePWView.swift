//
//  ChangePWView.swift
//  PMS
//
//  Created by jge on 2020/10/08.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ChangePWView: View {
    @ObservedObject var mypageVM = MypageViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            VStack(spacing: UIFrame.UIHeight / 13) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("현재 비밀번호")
                        .foregroundColor(Color("Blue"))
                    ChangePWTextField(placeholder: "현재 비밀번호를 입력해주세요", text: self.$mypageVM.nowPassword, isHidden: self.$mypageVM.nowisHidden)
                    Text("새 비밀번호")
                        .foregroundColor(Color("Blue"))
                    ChangePWTextField(placeholder: "변경할 비밀번호를 입력해주세요", text: self.$mypageVM.newPassword, isHidden: self.$mypageVM.newisHidden)
                    Text("비밀번호 확인")
                        .foregroundColor(Color("Blue"))
                    CheckTextField(text: self.$mypageVM.confirmPassword, isError: self.$mypageVM.confirmError, placeholder: "변경한 비밀번호를 확인해주세요", isChange: true, errorMsg: self.$mypageVM.errorMsg)
                }
                ButtonView(text: "확인", color: "Blue")
                    .onTapGesture {
                        self.mypageVM.confirmAlert = true
                }
            }
            .padding([.leading, .trailing], 30)
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
                .navigationBarTitle("비밀번호 변경", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Image("NavArrow")
                        .foregroundColor(.black)
            })
                if self.mypageVM.passwordAlert == true {
                    checkErrorView(text: "현재 비밀번호가 일치하지 않습니다.", isAlert: self.$mypageVM.passwordAlert)
            }
            if self.mypageVM.confirmAlert == true {
                ZStack {
                    Color(.black).opacity(0.3)
                    VStack(spacing: 20) {
                        Text("비밀번호를 번경하시겠습니까?")
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                        CustomDivider()
                        HStack {
                            Spacer()
                            Text("취소")
                                .onTapGesture {
                                    self.mypageVM.logoutAlert = false
                            }
                            Spacer()
                            Spacer()
                            Text("확인")
                                .foregroundColor(Color("Blue"))
                                .onTapGesture {
                                    self.mypageVM.confirmAlert = false
                                    self.mode.wrappedValue.dismiss()
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: UIFrame.UIWidth - 80)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
        }
    }
}

struct ChangePWTextField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isHidden: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                if self.isHidden {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
                
                if text != "" {
                    Button(action: {
                        self.isHidden.toggle()
                    }) {
                        Image(systemName: SFSymbolKey.eye.rawValue)
                            .resizable()
                            .frame(width: 25, height: 15)
                            .foregroundColor(.gray)
                    }.padding(.trailing, 10)
                }
            }.padding(.leading, 10)
            
            if text != "" {
                VStack {
                    Color( "Blue").frame(height: CGFloat(4) / UIScreen.main.scale)
                }
            } else {
                VStack {
                    CustomDivider()
                }
            }
        }
    }
}

struct ChangePWView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChangePWView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ChangePWView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
