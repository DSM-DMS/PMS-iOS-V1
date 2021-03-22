//
//  OutsideDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/08.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct OutsideDetailView: View {
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var settings: NavSettings
    @State var offset = CGSize.zero
    var body: some View {
        ScrollView {
            ForEach(1...10, id: \.self) { _ in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray"))
                        .frame(height: UIFrame.UIWidth / 3)
                        .shadow(radius: 4)
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            BlueTabView()
                            Text("사유")
                        }
                        Text("사유 : 그냥")
                            .foregroundColor(.gray)
                        Text("장소 : 운심부지처")
                            .foregroundColor(.gray)
                    }.padding(.leading, 30)
                }.padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 10)
            }.padding([.top, .bottom], 10)
        }.onAppear {
            self.settings.isNav = true
        }
        .navigationBarTitle("상/벌점 내역", displayMode: .inline)
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
