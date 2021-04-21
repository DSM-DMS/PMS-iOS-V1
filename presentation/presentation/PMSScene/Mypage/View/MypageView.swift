//
//  MypageView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import domain

struct MypageView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var mypageVM: MypageViewModel
    @Binding var nicknameAlert: Bool
    @Binding var studentsAlert: Bool
    @Binding var logoutAlert: Bool
    @State var isNav: Bool = true
    
    var appDI: AppDIInterface
    
    var body: some View {
        NavigationView {
            GeometryReader { _ in
                ZStack {
                    MypageBackground()
                    VStack {
                        VStack(spacing: 20) {
                            MypageTopView(nickname: self.mypageVM.nickname, student: self.$mypageVM.currentStudent, nicknameAlert: self.$nicknameAlert, studentAlert: self.$studentsAlert)
                            
                            if !UDManager.shared.isLogin {
                                TwoScoreView(plus: self.$mypageVM.plusScore, minus: self.$mypageVM.minusScore)
                            } else {
                                NavigationLink(destination: ScoreDetailView()) {
                                    TwoScoreView(plus: self.$mypageVM.plusScore, minus: self.$mypageVM.minusScore)
                                }
                            }
                            
                            BlueStatusView(text: self.mypageVM.status)
                            
                            if !UDManager.shared.isLogin {
                                VStack {
                                    Spacer()
                                    MypageButtonView(text: "로그인")
                                        .onTapGesture {
                                            self.mypageVM.showLoginModal.toggle()
                                        }
                                    Text("마이페이지 서비스는 로그인이 필요합니다.")
                                        .font(.callout)
                                        .foregroundColor(GEColor.blue)
                                    Spacer()
                                    Spacer()
                                }
                            } else if UDManager.shared.currentStudent == nil {
                                VStack(spacing: UIFrame.UIWidth / 15) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray")).frame(height: UIFrame.UIWidth / 9).modifier(shadowModifier())
                                        VStack {
                                            Text("학생을 추가해주세요")
                                                .foregroundColor(.black)
                                        }.padding()
                                    }
                                    Spacer()
                                    NavigationLink(destination: ChangePWView()) {
                                        MypageButtonView(text: "비밀번호 변경")
                                    }
                                    MypageButtonView(text: "로그아웃")
                                        .onTapGesture {
                                            withAnimation {
                                                self.logoutAlert.toggle()
                                            }
                                        }
                                    Spacer()
                                    Spacer()
                                }
                            } else {
                                VStack(spacing: UIFrame.UIWidth / 15) {
                                    StatusView(text: self.mypageVM.weekStatus, isMeal: self.mypageVM.isMeal)
                                    NavigationLink(destination: OutsideDetailView()) {
                                        MypageButtonView(text: "외출 내역 보기")
                                    }
                                    NavigationLink(destination: ChangePWView()) {
                                        MypageButtonView(text: "비밀번호 변경")
                                    }
                                    MypageButtonView(text: "로그아웃")
                                        .onTapGesture {
                                            withAnimation {
                                                self.logoutAlert.toggle()
                                            }
                                        }
                                }
                            }
                        }.padding([.leading, .trailing], 30)
                        Spacer()
                    }
                }
            }.onAppear {
                self.mypageVM.apply(.onAppear)
            }
            .sheet(isPresented: self.$mypageVM.showLoginModal) {
                PMSView(appDI: appDI, loginVM: appDI.loginDependencies())
                    .onDisappear {
                        print("disappear")
                        self.mypageVM.apply(.onAppear)
                    }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(isNav)
        }.accentColor(GEColor.black)
        
    }
}

// struct MypageView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MypageView(nicknameAlert: .constant(false), studentsAlert: .constant(false), logoutAlert: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
//                .previewDisplayName("iPhone XS Max")
//            MypageView(nicknameAlert: .constant(false), studentsAlert: .constant(false), logoutAlert: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//        }
//    }
// }

struct ScoreView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).shadow(radius: 10).frame(width: UIFrame.UIWidth / 2 - 50, height: UIFrame.UIHeight / 10)
    }
}

struct TwoScoreView: View {
    @Binding var plus: Int
    @Binding var minus: Int
    var body: some View {
        
        HStack(spacing: 30) {
            ZStack {
                ScoreView()
                VStack {
                    Text(String(plus))
                        .font(.title)
                        .foregroundColor(GEColor.black)
                    Text("상점")
                        .foregroundColor(GEColor.blue)
                }
            }
            ZStack {
                ScoreView()
                VStack {
                    Text(String(minus))
                        .font(.title)
                        .foregroundColor(GEColor.black)
                    Text("벌점")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct MypageTopView: View {
    var nickname: String
    @Binding var student: String
    @EnvironmentObject var settings: NavSettings
    @Binding var nicknameAlert: Bool
    @Binding var studentAlert: Bool
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.nicknameAlert.toggle()
                }
            }) {
                Text(!UDManager.shared.isLogin ? "비로그인 유저" : nickname)
                    .font(.title)
                    .foregroundColor(.white)
                GEImage.pencil
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {
                if UDManager.shared.isLogin {
                    withAnimation(.easeIn(duration: 0.1)) {
                        self.studentAlert.toggle()
                    }
                }
            }, label: {
                HStack {
                    Text(self.student)
                        .font(.headline)
                        .foregroundColor(.white)
                    GEImage.bottomArrow
                        .foregroundColor(.white)
                }
            })
            .disabled(!UDManager.shared.isLogin)
            .opacity(!UDManager.shared.isLogin ? 0.5 : 1.0)
        }
        .frame(height: 70)
        .padding([.leading, .trailing], 20)
        .padding(.top, UIFrame.UIWidth / 15)
        .padding(.top, self.edges!.bottom == 0 ? 0 : UIFrame.UIWidth / 10)
    }
}

struct MypageBackground: View {
    var body: some View {
        VStack {
            GEColor.blue
                .frame(height: UIFrame.UIHeight / 4)
            Spacer()
        }
        
    }
}

struct MypageButtonView: View {
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIWidth / 7).shadow(radius: 5)
            VStack {
                HStack {
                    Text(text)
                        .foregroundColor(GEColor.black)
                    Spacer()
                    Text(">")
                        .foregroundColor(GEColor.black)
                }
            }.padding()
        }
    }
}

struct BlueStatusView: View {
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30).foregroundColor(GEColor.blue).frame(height: UIFrame.UIWidth / 12)
            Text(text)
                .foregroundColor(.white)
        }.padding([.leading, .trailing])
    }
}

struct StatusView: View {
    var text: String
    var isMeal: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIWidth / 4.3).shadow(radius: 5)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("이번 주 잔류 상태")
                    Text("주말급식 신청 여부")
                }.padding(.leading)
                .foregroundColor(GEColor.black)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(text)
                    Image(self.isMeal ? "O" : "X").padding(.trailing, 5)
                }.padding(.trailing)
            }
            VStack {
                HStack {
                    Spacer()
                }
                HStack {
                    Spacer()
                }
            }.padding()
        }
    }
}
