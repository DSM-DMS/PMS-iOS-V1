//
//  Home.swift
//  PMS
//
//  Created by jge on 2020/10/14.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import domain

public struct Home: View {
    @EnvironmentObject var settings: NavSettings
    @EnvironmentObject var login: LoginSettings
    
    @State var index = 1
    @State var offset: CGFloat = UIScreen.main.bounds.width
    
    var width = UIScreen.main.bounds.width
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @EnvironmentObject var mypageVM: MypageViewModel
    @State var selectedStudent: String = ""
    
    let mealVM = MealViewModel()
    
    public init() {}
    
    public var body: some View {
        ZStack {
            GeometryReader { g in
                HStack(spacing: 0) {
                    StoryboardtoUI()
                        .frame(width: g.size.width)
                    
                    MealView().environmentObject(mealVM)
                        .frame(width: g.size.width)
                    
                    NoticeView()
                        .frame(width: g.size.width)
                    
                    IntroduceView()
                        .frame(width: g.size.width)
                    
                    MypageView(nicknameAlert: self.$mypageVM.nicknameAlert, studentsAlert: self.$mypageVM.studentsAlert, logoutAlert: self.$mypageVM.logoutAlert)
                        .frame(width: g.size.width)
                }
                .offset(x: self.offset)
            }
            if self.settings.isNav == false {
                VStack {
                    Spacer()
                    VStack(spacing: -10) {
                        AppBar(index: self.$index, offset: self.$offset)
                        Rectangle()
                            .frame(height: self.edges!.bottom == 0 ? 10 : 30).foregroundColor(GEColor.white)
                    }
                }
                .edgesIgnoringSafeArea(.all)
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
                                    self.mypageVM.showLoginModal = true
                                    UDManager.shared.isLogin = false
                                }
                            Spacer()
                        }
                        
                    }
                    .padding()
                    .frame(width: UIFrame.UIWidth - 80)
                    .modifier(alertBGModifier())
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
            if self.mypageVM.nicknameAlert {
                ZStack {
                    Color(.black).opacity(0.3)
                    VStack(spacing: 20) {
                        VStack {
                            TextField("새로운 닉네임을 입력해주세요", text: self.$mypageVM.newNickname)
                            if self.mypageVM.newNickname != "" {
                                GEColor.blue.frame(height: 1)
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
                                    withAnimation {
                                        self.mypageVM.nicknameAlert.toggle()
                                    }
                                }
                            Spacer()
                            Spacer()
                            Text("확인")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    self.mypageVM.apply(.changeName)
                                    withAnimation {
                                        self.mypageVM.nicknameAlert.toggle()
                                    }
                                }
                            Spacer()
                        }
                        
                    }
                    .padding()
                    .frame(width: UIFrame.UIWidth - 80)
                    .modifier(alertBGModifier())
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
            if self.mypageVM.studentsAlert {
                ZStack {
                    Color(.black).opacity(0.3)
                        .onTapGesture {
                            withAnimation {
                                self.mypageVM.studentsAlert = false
                            }
                        }
                    VStack {
                        Spacer()
                        VStack {
                            Color(.gray).frame(width: UIFrame.UIWidth / 5, height: 2)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                            
                            if UDManager.shared.currentStudent == nil {
                                VStack(spacing: 10) {
                                    Text("학생이 아무도 없습니다.").foregroundColor(.gray)
                                    Divider()
                                }.padding([.top, .bottom], 10)
                            } else {
                                ForEach(mypageVM.studentsArray, id: \.self) { user in
                                    VStack(spacing: 20) {
                                        HStack {
                                            Text(user)
                                                .foregroundColor(GEColor.black)
                                                .onTapGesture {
                                                    selectedStudent = user
                                                    UDManager.shared.currentStudent = selectedStudent
                                                    mypageVM.apply(.onAppear)
                                                }
                                            Spacer()
                                            Image("Minus")
                                                .onTapGesture {
                                                    selectedStudent = user
                                                    withAnimation {
                                                        self.mypageVM.deleteAlert = true
                                                    }
                                                }
                                        }
                                        Divider()
                                    }.padding([.leading, .trailing], 20)
                                    .padding([.top, .bottom], 10)
                                }
                            }
                            
                            HStack {
                                HStack {
                                    Image("CirclePlus")
                                    Text("학생 추가하기")
                                }.onTapGesture {
                                    withAnimation {
                                        self.mypageVM.studentCodeAlert = true
                                    }
                                }
                                .padding([.leading, .trailing], 10)
                                .padding(.bottom, self.edges!.bottom == 0 ? 10 : 30)
                                Spacer()
                            }
                            
                        }.padding([.leading, .trailing], 10)
                        .background(
                            VStack(spacing: -13) {
                                RoundedRectangle(cornerRadius: 20).foregroundColor(GEColor.white).shadow(radius: 3)
                                Rectangle().foregroundColor(GEColor.white).frame(height: 10)
                            })
                    }
                    
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
            if self.mypageVM.studentCodeAlert {
                ZStack {
                    Color(.black).opacity(0.3)
                    VStack(spacing: 20) {
                        VStack(alignment: .center) {
                            Text("자녀 확인 코드를 입력해주세요")
                            PassCodeInputField(inputModel: self.mypageVM.passCodeModel)
                                .modifier(Shake(animatableData: CGFloat(self.mypageVM.attempts)))
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
                                .disabled(!self.mypageVM.passCodeModel.isValid)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    self.mypageVM.apply(.addStudent)
                                    self.mypageVM.passCodeModel.selectedCellIndex = 0
                                }
                            Spacer()
                        }
                        
                    }.animation(.spring())
                    .padding()
                    .frame(width: UIFrame.UIWidth - 80)
                    .modifier(alertBGModifier())
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
            if self.mypageVM.deleteAlert {
                ZStack {
                    Color(.black).opacity(0.3)
                    VStack(spacing: 20) {
                        VStack {
                            Text("'\(selectedStudent)'")
                            Text("목록에서 삭제하시겠습니까?")
                        }.padding(.top, 10)
                        
                        CustomDivider()
                        HStack {
                            Spacer()
                            Text("취소")
                                .onTapGesture {
                                    self.mypageVM.deleteAlert = false
                                }
                            Spacer()
                            Spacer()
                            Text("확인")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    self.mypageVM.deleteAlert = false
                                }
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: UIFrame.UIWidth - 80)
                    .modifier(alertBGModifier())
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
        }.onAppear {
            self.offset = 0
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            Home()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct AppBar: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var width = UIScreen.main.bounds.width
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3, content: {
            VStack {
                Capsule()
                    .fill(GEColor.blue)
                    .frame(width: UIFrame.UIWidth / 6, height: 3)
                    .offset(x: UIFrame.UIWidth / 6 * CGFloat(index - 1) + UIFrame.UIWidth / 45 * CGFloat(index - 1))
                    .animation(.default)
            }
            HStack {
                Button(action: {
                    self.index = 1
                    self.offset = 0
                }) {
                    TabButtonView(image: "Calendar", text: "일정", index: self.$index, buttonIndex: 1)
                }
                Button(action: {
                    self.index = 2
                    self.offset = -self.width
                }) {
                    TabButtonView(image: "Meal", text: "급식", index: self.$index, buttonIndex: 2)
                }
                
                Button(action: {
                    self.index = 3
                    self.offset = -self.width * 2
                }) {
                    TabButtonView(image: "Notice", text: "공지", index: self.$index, buttonIndex: 3)
                }
                
                Button(action: {
                    self.index = 4
                    self.offset = -self.width * 3
                }) {
                    TabButtonView(image: "Introduce", text: "소개", index: self.$index, buttonIndex: 4)
                }
                Button(action: {
                    self.index = 5
                    self.offset = -self.width * 4
                }) {
                    TabButtonView(image: "Mypage", text: "내 정보", index: self.$index, buttonIndex: 5)
                }
                
            }
        })
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(RoundedRectangle(cornerRadius: 20).shadow(radius: 10).foregroundColor(GEColor.white))
    }
}

struct TabButtonView: View {
    var image: String
    var text: String
    @Binding var index: Int
    var buttonIndex: Int
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.clear)
                .frame(height: 4)
            VStack(spacing: 0) {
                if self.index == buttonIndex {
                    Image(String(image + ".fill"))
                        .resizable()
                        .frame(width: 25, height: 25)
                } else {
                    Image(image)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                
                Text(text)
                    .foregroundColor(self.index == buttonIndex ?  GEColor.blue : Color.gray.opacity(0.7))
            }
        }
    }
}