//
//  TabView.swift
//  PMS
//
//  Created by jge on 2020/10/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

class NavSettings: ObservableObject {
    @Published var isNav: Bool = false
}

struct ContentView: View {
    let onNav = NavSettings()
    var body: some View {
        Home().environmentObject(onNav)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct Home: View {
    @EnvironmentObject var settings: NavSettings
    @State var index = 1
    @State var offset: CGFloat = UIScreen.main.bounds.width
    var width = UIScreen.main.bounds.width
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack {
            GeometryReader {g in
                HStack(spacing: 0) {
                    StoryboardtoUI()
                        .frame(width: g.frame(in: .global).width)
                    
                    MealView()
                        .frame(width: g.frame(in: .global).width)
                    
                    NoticeView()
                        .frame(width: g.frame(in: .global).width)
                    
                    IntroduceView()
                        .frame(width: g.frame(in: .global).width)
                    
                    MypageView()
                        .frame(width: g.frame(in: .global).width)
                }
                .offset(x: self.offset)
                .highPriorityGesture(DragGesture()
                .onEnded({ value in
                    if self.settings.isNav == false {
                        if value.translation.width > 50 {
                            print("right")
                            self.changeView(left: false)
                        }
                        if -value.translation.width > 50 {
                            print("left")
                            self.changeView(left: true)
                        }
                    }
                }))
            }
            if self.settings.isNav == false {
                VStack {
                    Spacer()
                    VStack(spacing: -10) {
                        AppBar(index: self.$index, offset: self.$offset)
                        Rectangle()
                            .frame(height: self.edges!.bottom == 0 ? 10 : 30).foregroundColor(.white)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }.onAppear {
            self.offset = 0
        }
    }
    
    func changeView(left: Bool) {
        if left {
            if self.index != 5 {
                self.index += 1
            }
        } else {
            if self.index != 0 {
                self.index -= 1
            }
        }
        
        if self.index == 1 {
            self.offset = 0
        } else if self.index == 2 {
            self.offset = -self.width
        } else if self.index == 3 {
            self.offset = -self.width * 2
        } else if self.index == 4 {
            self.offset = -self.width * 3
        } else {
            self.offset = -self.width * 4
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
                    .fill(Color("Blue"))
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
            .background(RoundedRectangle(cornerRadius: 20).shadow(radius: 10).foregroundColor(.white))
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
                    .foregroundColor(self.index == buttonIndex ? Color("Blue") : Color.gray.opacity(0.7))
            }
        }
    }
}
