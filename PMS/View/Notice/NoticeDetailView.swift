//
//  NoticeDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/09.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct NoticeDetailView: View {
    @ObservedObject var NoticeDetailVM = NoticeDetailViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    NoticeDetailTopView()
                    Divider()
                    ScrollView {
                        Text(self.NoticeDetailVM.noticeDesc)
                    }.padding([.top, .bottom], 10)
                        .frame(height: UIFrame.UIHeight / 4)
                    CustomDivider()
                    VStack {
                        NoticeCommentView()
                        NoticeCommentView()
                        NoticeCommentView()
                    }
                    
                }
            }.padding([.leading, .trailing], 20)
                .navigationBarTitle("공지 제목", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Image("NavArrow")
                })
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
            VStack {
                Spacer()
                CustomCommentView(text: self.$NoticeDetailVM.comment)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct NoticeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoticeDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            NoticeDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct NoticeDetailTopView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text("공지 제목")
                    .padding(.top, 10)
                HStack {
                    HStack {
                        Text("2020.08.19")
                        Text("AM 02:13")
                        Text("| 조회수")
                    }.foregroundColor(.gray)
                        .font(.callout)
                    Text("30")
                        .foregroundColor(Color("Blue"))
                        .font(.callout)
                }
            }
            Spacer()
            Image("Clip")
        }
    }
}

struct NoticeCommentView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).shadow(radius: 5).frame(height: UIFrame.UIHeight / 15)
                VStack(alignment: .leading) {
                    Text("댓글 내용")
                    Text("단 사람")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }.padding()
            }
        }.padding([.leading, .trailing], 5)
    }
}

struct CustomCommentView: View {
    @Binding var text: String
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white).frame(height: UIFrame.UIHeight / 11).shadow(radius: 5)
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white).frame(height: UIFrame.UIHeight / 17)
            }
            HStack {
                Text("@")
                    .foregroundColor(Color("Blue"))
                TextField("댓글을 남겨주세요", text: $text)
                Image("Enter")
            }.padding([.leading, .trailing], 10)
            
        }
    }
}
