//
//  PMSView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct PMSView: View {
    @EnvironmentObject var settings: LoginSettings
    var body: some View {
        NavigationView {
            VStack(spacing: UIFrame.UIWidth / 3) {
                Image("PMS")
                VStack(spacing: 30) {
                    NavigationLink(destination: LoginView()) {
                        ButtonView(text: "로그인", color: "Blue")
                    }
                    NavigationLink(destination: SignupView()) {
                        ButtonView(text: "회원가입", color: "Red")
                    }
                }
            }
            .navigationBarTitle("PMS", displayMode: .inline)
        }.accentColor(.black)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PMSView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PMSView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            PMSView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
        
    }
}
