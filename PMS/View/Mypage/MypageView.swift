//
//  MypageView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct MypageView: View {
    @EnvironmentObject var mypageVM: MypageViewModel
    @Binding var nicknameAlert: Bool
    @Binding var studentsAlert: Bool
    @Binding var logoutAlert: Bool
    @State var isNav: Bool = true
    
    var body: some View {
        NavigationView {
            GeometryReader { _ in
                ZStack {
                    MypageBackground()
                    VStack {
                        VStack(spacing: 20) {
                            MypageTopView(nickname: self.mypageVM.nickname, nicknameAlert: self.$nicknameAlert, studentAlert: self.$studentsAlert)
                            
                            NavigationLink(destination: ScoreDetailView()) {
                            TwoScoreView(plus: self.$mypageVM.plusScore, minus: self.$mypageVM.minusScore)
                            }
                            
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
                                            self.logoutAlert = true
                                        }
                                        
                                }
                            }
                        }.padding([.leading, .trailing], 30)
                        Spacer()
                    }
                }
            }.edgesIgnoringSafeArea(.top)
                .navigationBarHidden(isNav)
        }.accentColor(.black)
        
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MypageView(nicknameAlert: .constant(false), studentsAlert: .constant(false), logoutAlert: .constant(false))
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            MypageView(nicknameAlert: .constant(false), studentsAlert: .constant(false), logoutAlert: .constant(false))
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

            HStack(spacing: 30) {
                ZStack {
                    ScoreView()
                    VStack {
                        Text(String(plus))
                            .font(.title)
                            .foregroundColor(.black)
                        Text("상점")
                            .foregroundColor(Color("Blue"))
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

struct MypageTopView: View {
    var nickname: String
    @EnvironmentObject var settings: NavSettings
    @Binding var nicknameAlert: Bool
    @Binding var studentAlert: Bool
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
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
        .padding(.top, self.edges!.bottom == 0 ? 0 : UIFrame.UIWidth / 10)
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
            HStack {
                VStack {
                    Text("이번 주 잔류 상태")
                    Text("주말급식 신청 여부")
                }
                Spacer()
                VStack {
                    Text(text)
                    
                    Image(self.isMeal ? "O" : "X").padding(.trailing, 5)
                }
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
