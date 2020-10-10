//
//  NoticeView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct NoticeView: View {
    @ObservedObject var noticeVM = NoticeViewModel()
    @State private var numbers = ["가정통신문", "공지사항"]
    var body: some View {
        NavigationView {
            GeometryReader { _ in
                VStack(spacing: 15) {
                    TitleTextView(text: "공지사항")
                    SearchBar()
                    HStack {
                        Spacer()
                        Picker("Numbers", selection: self.$noticeVM.selectedIndex) {
                            ForEach(0 ..< self.numbers.count) { index in
                                Text(self.numbers[index]).tag(index)
                            }
                        }.frame(width: UIFrame.UIWidth / 2)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    VStack(spacing: UIFrame.UIWidth / 15) {
                        ScrollView {
                            ForEach(1...10, id: \.self) { _ in
                                NavigationLink(destination: NoticeDetailView()) {
                                    NoticeRectangle()
                                }
                            }
                        }.frame(height: UIFrame.UIHeight / 2)
                        HStack {
                            Image("LeftArrow")
                            Text("1")
                            Image("RightArrow")
                        }
                    }
                    
                }.padding([.leading, .trailing], 30)
                VStack {
                    Text("")
                }
            }.edgesIgnoringSafeArea(.top)
        }.accentColor(.black)
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoticeView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            NoticeView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct SearchBar: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(height: 30)
            HStack {
                Image(systemName: SFSymbolKey.search.rawValue)
                Text("검색할 공지 제목을 입력하세요.")
            }.padding(.leading, 10)
        }
    }
}

struct NoticeRectangle: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).shadow(radius: 5)
            VStack(spacing: 0) {
                HStack {
                    BlueTabView()
                    Text("공지 제목")
                        .foregroundColor(.black)
                }
                Text("2020/09/10")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
            }.padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 10)
        }.padding([.top, .leading, .trailing], 10)
    }
}
