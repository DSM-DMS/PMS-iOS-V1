//
//  NoticeDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/09.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Combine
import domain

struct NoticeDetailView: View {
    @EnvironmentObject var settings: NavSettings
    @ObservedObject var noticeVM: NoticeViewModel
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var id: Int
    
    init(noticeVM: NoticeViewModel, id: Int) {
        self.noticeVM = noticeVM
        self.id = id
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScrollView {
                    NoticeDetailTopView(title: self.noticeVM.noticeDetail.title, date: self.noticeVM.noticeDetail.date, isAlert: self.$noticeVM.pdfAlert )
                    Divider()
                    ScrollView {
                        Text(self.noticeVM.noticeDetail.body)
                    }.padding([.top, .bottom], 10)
                    .frame(height: UIFrame.UIHeight / 4)
                    CustomDivider()
                    ForEach(self.noticeVM.noticeDetail.comment, id: \.self) { comt in
                        NoticeCommentView(name: comt.user.name, desc: comt.body, reComment: comt.comment)
                    }
                }
            }.padding([.leading, .trailing], 20)
            .navigationBarTitle("공지사항", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
                self.settings.isNav = false
            }) {
                GEImage.navArrow
            })
            .modifier(backDrag(offset: self.$offset))
            VStack(spacing: -10) {
                if self.noticeVM.myComment.last == "@" {
                    ScrollView {
                        ForEach(1...4, id: \.self) { i in
                            ReferView(name: String(i))
                                .onTapGesture {
                                    self.noticeVM.myComment += String(i) + " "
                                }
                        }.padding(.top, 10)
                    }.frame(width: UIFrame.UIWidth, height: UIFrame.UIHeight / 4.5)
                    .background(Rectangle().foregroundColor(.white).shadow(radius: 3))
                }
                CustomCommentView(text: self.$noticeVM.myComment)
            }
            
            if self.noticeVM.pdfAlert {
                ZStack {
                    Color(.black).opacity(0.3)
                        .onTapGesture {
                            self.noticeVM.pdfAlert = false
                        }
                    HStack(spacing: 20) {
                        GEImage.download
                            .resizable()
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                self.noticeVM.downloadFile(fileName: self.noticeVM.pdfTitle)
                            }
                        Text(self.noticeVM.pdfTitle)
                        Spacer()
                        ZStack {
                            //                            NavigationLink(destination: PDFKitView(url: self.NoticeDetailVM.pdfUrl)) {
                            //                                PreviewTextView()
                            //                            }
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
            self.noticeVM.apply(.getNoticeDetail(id: id))
        }
    }
}

// struct NoticeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            NoticeDetailView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
//                .previewDisplayName("iPhone XS Max")
//            NoticeDetailView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//        }
//    }
// }

struct NoticeDetailTopView: View {
    var title: String
    var date: String
    @Binding var isAlert: Bool
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(title)
                    .padding(.top, 10)
                HStack {
                    HStack {
                        Text(date)
                        Text("AM 02:13")
                        Text("| 조회수")
                    }.foregroundColor(.gray)
                    .font(.callout)
                    Text("30")
                        .foregroundColor(GEColor.blue)
                        .font(.callout)
                }
            }
            Spacer()
            GEImage.clip
                .onTapGesture {
                    withAnimation {
                        self.isAlert.toggle()
                    }
                }
        }
    }
}

struct NoticeCommentView: View {
    var name: String
    var desc: String
    var reComment: [Comment]
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).shadow(radius: 5).frame(height: UIFrame.UIHeight / 15)
                VStack(alignment: .leading) {
                    Text(desc)
                        .multilineTextAlignment(.leading)
                    Text(name)
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }.padding()
            }
            if reComment != [] {
                ForEach(reComment, id: \.self) { comt in
                    HStack {
                        GEImage.reComment
                        NoticeCommentView(name: comt.user.name, desc: comt.body, reComment: comt.comment)
                    }
                }.padding(.leading, 15)
            }
        }.padding([.leading, .trailing], 5)
    }
}

struct CustomCommentView: View {
    @Binding var text: String
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 20).foregroundColor(GEColor.white).frame(height: UIFrame.UIHeight / 11).shadow(radius: 5)
                RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.white).frame(height: UIFrame.UIHeight / 17)
            }
            HStack {
                Text("@")
                    .foregroundColor(GEColor.blue)
                    .onTapGesture {
                        self.text += "@"
                    }
                ZStack {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIHeight / 20)
                    TextField("댓글을 남겨주세요", text: $text).padding(.leading, 10)
                }
                
                GEImage.enter
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
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.blue))
    }
}

struct ReferView: View {
    var name: String
    var body: some View {
        VStack {
            HStack {
                Text("@").foregroundColor(GEColor.blue)
                Text(name)
                Text("선생님")
                Spacer()
            }.padding(.all, 3)
            Divider()
        }.padding([.leading, .trailing], 20)
    }
}
