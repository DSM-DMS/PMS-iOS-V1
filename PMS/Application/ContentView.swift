//
//  TabView.swift
//  PMS
//
//  Created by jge on 2020/10/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import presentation

struct ContentView: View {
    let onNav = NavSettings()
//    let maypageVM = MypageViewModel()
    
    var appDI: AppDIInterface
    
    public init(appDI: AppDIInterface) {
        self.appDI = appDI
    }
    
    var body: some View {
        Home(appDI: appDI).environmentObject(onNav).environmentObject(appDI.mypageDependencies())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(appDI: AppDI())
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ContentView(appDI: AppDI())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
