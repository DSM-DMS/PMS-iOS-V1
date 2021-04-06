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
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            VStack(spacing: UIFrame.UIHeight / 13) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("현재 비밀번호")
                        .foregroundColor(GEColor.blue)
                    ChangePWTextField(placeholder: "현재 비밀번호를 입력해주세요", text: self.$mypageVM.nowPassword, isHidden: self.$mypageVM.nowisHidden)
                    Text("새 비밀번호")
                        .foregroundColor(GEColor.blue)
                    ChangePWTextField(placeholder: "변경할 비밀번호를 입력해주세요", text: self.$mypageVM.newPassword, isHidden: self.$mypageVM.newisHidden)
                    Text("비밀번호 확인")
                        .foregroundColor(GEColor.blue)
                    CheckTextField(text: self.$mypageVM.confirmPassword, isError: self.$mypageVM.confirmError, placeholder: "변경한 비밀번호를 확인해주세요", isChange: true, errorMsg: self.$mypageVM.errorMsg)
                }
                ButtonView(text: "확인", color: GEEColor.blue.rawValue)
                    .onTapGesture {
                        self.mypageVM.apply(.changePassword)
                    }
            }
            .padding([.leading, .trailing], 30)
            .modifier(backDrag(offset: self.$offset))
            .navigationBarTitle("비밀번호 변경", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
                self.settings.isNav = false
            }) {
                Image("NavArrow")
                    .foregroundColor(.black)
            })
            if self.mypageVM.passwordAlert == true {
                checkErrorView(text: "현재 비밀번호가 일치하지 않습니다.", isAlert: self.$mypageVM.passwordAlert)
            }
            if self.mypageVM.passwordSuccessAlert {
                SuccessView(text: "비밀번호가 변경되었습니다.")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                            self.mode.wrappedValue.dismiss()
                            self.settings.isNav = false
                        }
                    }
            }
            if self.mypageVM.confirmAlert == true {
                ZStack {
                    Color(.black).opacity(0.3)
                    VStack(spacing: 20) {
                        Text("비밀번호를 변경하시겠습니까?")
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                        CustomDivider()
                        HStack {
                            Spacer()
                            Text("취소")
                                .onTapGesture {
                                    withAnimation {
                                        self.mypageVM.confirmAlert.toggle()
                                    }
                                }
                            Spacer()
                            Spacer()
                            Text("확인")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    self.mypageVM.apply(.changePassword)
                                    withAnimation {
                                        self.mypageVM.confirmAlert.toggle()
                                    }
                                }
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: UIFrame.UIWidth - 80)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
        }.onAppear {
            self.settings.isNav = true
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
                    GEColor.blue.frame(height: CGFloat(4) / UIScreen.main.scale)
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
