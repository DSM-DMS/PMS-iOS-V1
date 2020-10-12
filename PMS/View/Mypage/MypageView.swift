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
        NavigationView {
            GeometryReader { _ in
                ZStack {
                    MypageBackground()
                    VStack {
                        VStack(spacing: 20) {
                            MypageTopView(nickname: self.mypageVM.nickname, nicknameAlert: self.$mypageVM.nicknameAlert, studentAlert: self.$mypageVM.studentsAlert)
                            
                            TwoScoreView(plus: self.$mypageVM.plusScore, minus: self.$mypageVM.minusScore)
                            
                            BlueStatusView(text: self.mypageVM.status)
                            
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
                                            self.mypageVM.logoutAlert = true
                                        }
                                        
                                }
                            }
                        }.padding([.leading, .trailing], 30)
                        Spacer()
                    }
                    if self.mypageVM.logoutAlert {
                        ZStack {
                            Color(.black).opacity(0.3)
                            VStack(spacing: 20) {
                                Text("로그아웃 하시겠습니까?")
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
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            self.mypageVM.logoutAlert = false
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding()
                            .frame(width: UIFrame.UIWidth - 80)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                        }.edgesIgnoringSafeArea([.top, .bottom])
                    }
                    if self.mypageVM.nicknameAlert {
                        ZStack {
                            Color(.black).opacity(0.3)
                            VStack(spacing: 20) {
                                VStack {
                                    TextField("새로운 닉네임을 입력해주세요", text: self.$mypageVM.newNickname)
                                    if self.mypageVM.newNickname != "" {
                                        Color("Blue").frame(height: 1)
                                    } else {
                                        Color(.gray).frame(height: 1)
                                    }
                                    
                                }.padding(.top, 20)
                                .padding([.leading, .trailing], 20)
                                
                                CustomDivider()
                                HStack {
                                    Spacer()
                                    Text("취소")
                                        .onTapGesture {
                                            self.mypageVM.nicknameAlert = false
                                    }
                                    Spacer()
                                    Spacer()
                                    Text("확인")
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            self.mypageVM.nicknameAlert = false
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding()
                            .frame(width: UIFrame.UIWidth - 80)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                        }.edgesIgnoringSafeArea([.top, .bottom])
                    }
                    if self.mypageVM.studentCodeAlert {
                        ZStack {
                            Color(.black).opacity(0.3)
                            VStack(spacing: 20) {
                                VStack(alignment: .center) {
                                    Text("자녀 확인 코드를 입력해주세요")
                                    TextField("", text: self.$mypageVM.newNickname)
                                        .keyboardType(.numberPad)
                                        .frame(width: UIFrame.UIWidth / 2)
                                    if self.mypageVM.newNickname != "" {
                                        HStack {
                                            DottedView(color: "Blue")
                                        }
                                    } else {
                                        DottedView(color: "SystemGray")
                                    }
                                    
                                }
                                .padding([.leading, .trailing], 20)
                                
                                CustomDivider()
                                HStack {
                                    Spacer()
                                    Text("취소")
                                        .onTapGesture {
                                            self.mypageVM.studentCodeAlert = false
                                    }
                                    Spacer()
                                    Spacer()
                                    Text("확인")
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            self.mypageVM.studentCodeAlert = false
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding()
                            .frame(width: UIFrame.UIWidth - 80)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                        }.edgesIgnoringSafeArea([.top, .bottom])
                    }
                    if self.mypageVM.studentsAlert {
                        ZStack {
                            Color(.black).opacity(0.3)
                            VStack {
                                Spacer()
                                VStack {
                                    Color(.gray).frame(width: UIFrame.UIWidth / 5, height: 2)
                                        .padding(.top, 5)
                                        .padding(.bottom, 10)
                                    
                                    ForEach(1...2, id: \.self) { _ in
                                        VStack(spacing: 20) {
                                            HStack {
                                                Text("1319 정고은")
                                                Spacer()
                                                Image("Minus")
                                            }
                                            Divider()
                                        }.padding([.leading, .trailing], 20)
                                        .padding([.top, .bottom], 10)
                                    }
                                    
                                    HStack {
                                        HStack {
                                            Image("CirclePlus")
                                            Text("학생 추가하기")
                                        }.padding([.leading, .trailing], 10)
                                        .padding(.bottom, 20)
                                        
                                        Spacer()
                                    }
                                    
                                }.padding([.leading, .trailing], 10)
                                .background(
                                    VStack(spacing: -13) {
                                        RoundedRectangle(cornerRadius: 20).foregroundColor(.white).shadow(radius: 3)
                                        Rectangle().foregroundColor(.white).frame(height: 10)
                                    })
                            }
                            
                        }.edgesIgnoringSafeArea([.top, .bottom])
                    }
                }
            }.edgesIgnoringSafeArea(.top)
        }.accentColor(.black)
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
    @Binding var plus: Int
    @Binding var minus: Int
    var body: some View {
        NavigationLink(destination: ScoreDetailView()) {
            HStack(spacing: 30) {
                ZStack {
                    ScoreView()
                    VStack {
                        Text(String(plus))
                            .font(.title)
                            .foregroundColor(.black)
                        Text("상점")
                            .foregroundColor(.red)
                    }
                }
                ZStack {
                    ScoreView()
                    VStack {
                        Text(String(minus))
                            .font(.title)
                            .foregroundColor(.black)
                        Text("벌점")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct MypageTopView: View {
    var nickname: String
    @EnvironmentObject var settings: NavSettings
    @Binding var nicknameAlert: Bool
    @Binding var studentAlert: Bool
//    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.nicknameAlert = true
                }
            }) {
                Text(nickname)
                    .font(.title)
                    .foregroundColor(.white)
                Image("Pencil")
            }
            Spacer()
            HStack {
                Text("학생추가")
                    .font(.headline)
                    .foregroundColor(.white)
                Image("BottomArrow")
            }.onTapGesture {
                withAnimation {
                    self.studentAlert = true
                }
            }
            
        }
        .frame(height: 70)
        .padding([.leading, .trailing], 20)
        .padding(.top, UIFrame.UIWidth / 15)
//        .padding(.top, self.edges!.bottom == 0 ? 0 : UIFrame.UIWidth / 10)
    }
}

struct MypageBackground: View {
    var body: some View {
        VStack {
            VStack {
                Color("Blue")
                    .frame(height: UIFrame.UIHeight / 4)
            }
            VStack {
                Color(.white)
            }
        }
        
    }
}

struct MypageButtonView: View {
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray")).frame(height: UIFrame.UIWidth / 7).shadow(radius: 5)
            VStack {
                HStack {
                    Text(text)
                        .foregroundColor(.black)
                    Spacer()
                    Text(">")
                        .foregroundColor(.black)
                }
            }.padding()
        }
    }
}

struct BlueStatusView: View {
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30).foregroundColor(Color("Blue")).frame(height: UIFrame.UIWidth / 12)
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
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray")).frame(height: UIFrame.UIWidth / 4.3).shadow(radius: 5)
            VStack {
                HStack {
                    Text("이번 주 잔류 상태")
                    Spacer()
                    Text(text)
                }
                HStack {
                    Text("주말급식 신청 여부")
                    Spacer()
                    Image(self.isMeal ? "O" : "X").padding(.trailing, 5)
                }
            }.padding()
        }
    }
}

struct DottedView: View {
    var color: String
    var body: some View {
        HStack {
            Color(color).frame(width: UIFrame.UIWidth / 15, height: 2)
            Color(color).frame(width: UIFrame.UIWidth / 15, height: 2)
            Color(color).frame(width: UIFrame.UIWidth / 15, height: 2)
            Color(color).frame(width: UIFrame.UIWidth / 15, height: 2)
            Color(color).frame(width: UIFrame.UIWidth / 15, height: 2)
            Color(color).frame(width: UIFrame.UIWidth / 15, height: 2)
        }
    }
}
