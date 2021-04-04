//
//  DeveloperView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject var introduceVM = IntroduceViewModel()
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var images = [ "Front1", "Front2", "Back1", "Back2", "Android1", "Android2", "iOS1"]
    var fields = ["웹", "웹", "서버", "서버", "안드로이드", "안드로이드", "iOS"]
    var persons = ["강은빈", "이진우", "정지우", "김정빈", "이은별", "김재원", "정고은"]
    
    var body: some View {
        ScrollView {
            ForEach(0...3, id: \.self) { index in
                HStack {
                    DeveloperRectangle(image: images[index*2], person: persons[index*2], field: fields[index*2])
                        .padding([.leading, .trailing], 10)
                        .padding([.bottom, .top], 3)
                    if index != 3 {
                        DeveloperRectangle(image: images[index*2+1], person: persons[index*2+1], field: fields[index*2+1])
                            .padding([.leading, .trailing], 10)
                            .padding([.bottom, .top], 3)
                    }
                    
                }.padding(.bottom)
            }.padding([.leading, .trailing], 30)
            .padding([.top, .bottom], 10)
        }.onAppear {
            self.settings.isNav = true
        }
        .navigationBarTitle("개발자 소개", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            self.settings.isNav = false
        }) {
            Image("NavArrow")
        })
        .modifier(myPageDrag(offset: self.$offset))
    }
}

struct DeveloperRectangle: View {
    var image: String
    var person: String
    var field = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(width: UIFrame.UIWidth / 2.6, height: UIFrame.UIHeight / 4.7).shadow(radius: 5)
            VStack(spacing: 15) {
                Image(image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                    .clipShape(Circle())
                
                VStack(spacing: 5) {
                    Text(person)
                        .foregroundColor(.black)
                        .font(.system(size: 23))
                    
                    Text(field).foregroundColor(.gray).font(.body)
                }
                
            }
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DeveloperView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            DeveloperView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
