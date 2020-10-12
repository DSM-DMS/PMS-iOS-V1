//
//  ScoreDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/08.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ScoreDetailView: View {
    @ObservedObject var MypageVM = MypageViewModel()
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var body: some View {
        ScrollView {
            ForEach(1...10, id: \.self) { _ in 
                ScoreRow(text: "사유", date: "2020/09/21", status: "-1")
            }.padding([.top, .bottom], 10)
            
        }.onAppear {
            self.settings.isNav = true
        }
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
            .navigationBarTitle("상/벌점 내역", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
                self.settings.isNav = false
            }) {
                Image("NavArrow")
                    .foregroundColor(.black)
            })
    }
}

struct ScoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScoreDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ScoreDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct ScoreRow: View {
    var text: String
    var date: String
    var status: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("Gray"))
                .frame(height: UIFrame.UIWidth / 6)
                .shadow(radius: 5)
            HStack {
                VStack(alignment: .leading) {
                    Text(text)
                    Text(date)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(status)
            }.padding([.leading, .trailing], 30)
        }.padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 5)
    }
}
