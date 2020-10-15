//
//  NoticeDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/09.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Combine

struct NoticeDetailView: View {
    @EnvironmentObject var settings: NavSettings
    @ObservedObject var NoticeDetailVM = NoticeDetailViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScrollView {
                    NoticeDetailTopView(isAlert: self.$NoticeDetailVM.pdfAlert)
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
                self.settings.isNav = false
            }) {
                Image("NavArrow")
            })
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                        if abs(self.offset.width) > 0 {
                            self.mode.wrappedValue.dismiss()
                            self.settings.isNav = false
                        }
                    }
                    .onEnded { _ in
                        if abs(self.offset.width) > 0 {
                            self.mode.wrappedValue.dismiss()
                            self.settings.isNav = false
                        } else {
                            self.offset = .zero
                        }
                    }
            )
            VStack(spacing: -10) {
                if self.NoticeDetailVM.comment.contains("@") {
                    ScrollView {
                        ForEach(1...4, id: \.self) { i in
                            ReferView(name: String(i))
                                .onTapGesture {
                                    self.NoticeDetailVM.comment += String(i) + " "
                                }
                        }.padding(.top, 10)
                    }.frame(width: UIFrame.UIWidth, height: UIFrame.UIHeight / 4.5)
                    .background(Rectangle().foregroundColor(.white).shadow(radius: 3))
                }
                CustomCommentView(text: self.$NoticeDetailVM.comment)
            }
            
            if self.NoticeDetailVM.pdfAlert {
                ZStack {
                    Color(.black).opacity(0.3)
                        .onTapGesture {
                                self.NoticeDetailVM.pdfAlert = false
                        }
                    HStack(spacing: 20) {
                        Image("Download")
                            .onTapGesture {
                                self.NoticeDetailVM.downloadFile(fileName: self.NoticeDetailVM.pdfTitle)
                            }
                        Text(self.NoticeDetailVM.pdfTitle)
                        Spacer()
                        ZStack {
                            NavigationLink(destination: PDFKitView(url: self.NoticeDetailVM.pdfUrl)) {
                                PreviewTextView()
                            }
                        }
                    }
                    .padding(.all, 20)
                    .padding([.top, .bottom], 10)
                    .frame(width: UIFrame.UIWidth - 80)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 3))
                }.edgesIgnoringSafeArea([.top, .bottom])
                
            }
        }.keyboardAdaptive()
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.settings.isNav = true
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
    @Binding var isAlert: Bool
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
                .onTapGesture {
                    withAnimation {
                        self.isAlert = true
                    }
                }
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
                RoundedRectangle(cornerRadius: 20).foregroundColor(Color.white).frame(height: UIFrame.UIHeight / 11).shadow(radius: 5)
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white).frame(height: UIFrame.UIHeight / 17)
            }
            HStack {
                Text("@")
                    .foregroundColor(Color("Blue"))
                    .onTapGesture {
                        self.text += "@"
                    }
                ZStack {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(height: UIFrame.UIHeight / 20)
                    TextField("댓글을 남겨주세요", text: $text).padding(.leading, 10)
                }
                
                Image("Enter")
            }.padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
        }
    }
}

struct PreviewTextView: View {
    var body: some View {
        Text("미리보기").foregroundColor(.white)
            .font(.callout)
            .padding(.all, 5)
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Blue")))
    }
}

struct ReferView: View {
    var name: String
    var body: some View {
        VStack {
            HStack {
                Text("@").foregroundColor(Color("Blue"))
                Text(name)
                Text("선생님")
                Spacer()
            }.padding(.all, 3)
            Divider()
        }.padding([.leading, .trailing], 20)
    }
}
