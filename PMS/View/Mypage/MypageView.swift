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
                            MypageTopView(nickname: self.mypageVM.nickname)
                            
                            TwoScoreView(plus: self.$mypageVM.plusScore, minus: self.$mypageVM.minusScore)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 30).foregroundColor(Color("Blue")).frame(height: UIFrame.UIWidth / 12)
                                Text(self.mypageVM.status)
                                    .foregroundColor(.white)
                            }.padding([.leading, .trailing])
                            
                            VStack(spacing: UIFrame.UIWidth / 15) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray")).frame(height: UIFrame.UIWidth / 4.3).shadow(radius: 5)
                                    VStack {
                                        HStack {
                                            Text("이번 주 잔류 상태")
                                            Spacer()
                                            Text(self.mypageVM.weekStatus)
                                        }
                                        HStack {
                                            Text("주말급식 신청 여부")
                                            Spacer()
                                            Image(self.mypageVM.isMeal ? "O" : "X")
                                        }
                                    }.padding()
                                }
                                NavigationLink(destination: OutsideDetailView()) {
                                    MypageButtonView(text: "외출 내역 보기")
                                }
                                NavigationLink(destination: ChangePWView()) {
                                    MypageButtonView(text: "비밀번호 변경")
                                }
                                MypageButtonView(text: "로그아웃")
                                    .onTapGesture {
                                        self.mypageVM.logoutAlert = true
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
                                Color.gray.frame(height: CGFloat(4) / UIScreen.main.scale)
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
                                            self.mypageVM.logoutAlert = false
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding()
                            .frame(width: UIFrame.UIWidth - 80)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                        }.edgesIgnoringSafeArea(.bottom)
                    }
                }
            }.edgesIgnoringSafeArea(.top)
        }
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
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        HStack {
            Text(nickname)
                .font(.title)
                .foregroundColor(.white)
            Image("Pencil")
            Spacer()
            Text("학생추가")
                .font(.headline)
                .foregroundColor(.white)
            Image("BottomArrow")
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
