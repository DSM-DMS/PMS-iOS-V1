//
//  ScoreDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/08.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ScoreDetailView: View {
    @EnvironmentObject var mypageVM: MypageViewModel
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var body: some View {
        ScrollView {
            if self.mypageVM.points == nil || ((self.mypageVM.points?.points.isEmpty) == true) {
                Spacer()
                Text("아직 상벌점 이력이 없습니다.")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                Spacer(minLength: 10.0)
                ForEach(self.mypageVM.points!.points, id: \.self) { point in
                    ScoreRow(text: point.reason, date: point.date, status: point.type ? "+" + String(point.point) : "-" +  String(point.point), isMinus: !point.type)
                }.padding(.bottom, 5)
            }
        }.onAppear {
            self.mypageVM.apply(.getPoint)
            self.settings.isNav = true
        }
        .modifier(myPageDrag(offset: self.$offset))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("상/벌점 내역", displayMode: .inline)
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
    var isMinus: Bool
    
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
                if isMinus {
                    Text(status).foregroundColor(.red).fontWeight(.medium)
                } else {
                    Text(status).foregroundColor(Color("Blue")).fontWeight(.medium)
                }
                
            }.padding([.leading, .trailing], 30)
        }.padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 5)
    }
}
