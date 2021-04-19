//
//  IntroduceDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Kingfisher

public struct ClubDetailView: View {
    @EnvironmentObject var IntroduceDetailVM: IntroduceViewModel
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var name: String
    
    public var body: some View {
        GeometryReader { _ in
            VStack(spacing: 10) {
                CustomDivider()
                ZStack {
                    KFImage(URL(string: IntroduceDetailVM.clubDetail.imageUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!.replacingOccurrences(of: "%3A", with: ":")))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIFrame.UIHeight / 4)
                }
                
                HStack {
                    ImageCircle()
                    ImageCircle()
                    ImageCircle()
                    ImageCircle()
                    ImageCircle()
                }
                CustomDivider()
                Text(IntroduceDetailVM.clubDetail.title)
                    .font(.title)
                    .fontWeight(.semibold)
                DetailIntroduce(title: "동아리 소개", text: IntroduceDetailVM.clubDetail.description)
                    .padding(.bottom)
                
                ClubMembersView(members: IntroduceDetailVM.clubDetail.member)
                
            }.padding(.top, 10)
            VStack {
                Text("")
            }
        }.onAppear {
            self.settings.isNav = true
            self.IntroduceDetailVM.apply(.getClubDetail(name: name))
        }
        .padding([.leading, .trailing], 30)
        .navigationBarTitle("\(self.name)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }) {
            Image("NavArrow")
        })
        .modifier(backDrag(offset: self.$offset))
    }
}

struct ClubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClubDetailView(name: "GG")
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ClubDetailView(name: "GG")
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct DetailIntroduce: View {
    var title: String
    var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIHeight / 10).shadow(radius: 5)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    BlueTabView()
                    Text(title)
                }
                
                Text(text)
                    .font(.callout)
                    .foregroundColor(Color.gray)
            }.padding([.leading, .trailing])
        }
    }
}

struct ClubMembersView: View {
    var members: [String]
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIHeight / 3.5).shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    GEColor.blue.frame(width: 3, height: 20)
                    Text("동아리 인원")
                }.padding(.top, 20)
                VStack(alignment: .leading) {
                    HStack {
                        Text(members.joined(separator: ", "))
                    }
                }.foregroundColor(Color.gray)
                .font(.callout)
                
            }.padding([.leading, .trailing])
        }
    }
}
