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
        GeometryReader { _ in
            VStack {
                VStack(alignment: .leading) {
                    Text("공지 제목")
                    HStack {
                        HStack {
                            HStack {
                                Text("2020.08.19")
                                Text("AM 02:13")
                                Text("| 조회수")
                            }.foregroundColor(.gray)
                            Text("30").foregroundColor(Color("Blue"))
                        }
                        Image("Clip")
                    }
                    
                }
            }.padding([.leading, .trailing], 30)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image("NavArrow")
            })
        }.gesture(
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
    }
}

struct NoticeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeDetailView()
    }
}
