//
//  OutsideDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/08.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct OutsideDetailView: View {
    @EnvironmentObject var mypageVM: MypageViewModel
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var settings: NavSettings
    @State var offset = CGSize.zero
    var body: some View {
        ScrollView {
            if self.mypageVM.outings == nil || ((self.mypageVM.outings?.outings.isEmpty) == true) {
                Spacer()
                Text("아직 외출 이력이 없습니다.")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                ForEach(self.mypageVM.outings!.outings, id: \.self) { outing in
                    OutsideRow(date: outing.date, reason: outing.reason, place: outing.place, type: outing.type)
                }.padding([.top, .bottom], 10)
            }
        }.onAppear {
            self.settings.isNav = true
        }
        .navigationBarTitle("외출 내역", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            self.settings.isNav = false
        }) {
            Image("NavArrow")
                .foregroundColor(.black)
        })
        .modifier(myPageDrag(offset: self.$offset))
    }
}

struct OutsideDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OutsideDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            OutsideDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct OutsideRow: View {
    var date: String
    var reason: String
    var place: String
    var type: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray"))
                .frame(height: UIFrame.UIWidth / 3)
                .shadow(radius: 4)
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    if type == "DISEASE" {
                        RedTabView()
                    } else {
                        BlueTabView()
                    }
                    Text(date)
                }
                Text("사유 : \(reason)")
                    .foregroundColor(.gray)
                Text("장소 : \(place)")
                    .foregroundColor(.gray)
            }.padding(.leading, 30)
        }.padding([.leading, .trailing], 20)
            .padding([.top, .bottom], 10)
    }
}
