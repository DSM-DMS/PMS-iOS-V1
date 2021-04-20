//
//  AppDelegate.swift
//  PMS
//
//  Created by jge on 2020/09/30.
//  Copyright © 2020 jge. All rights reserved.
//

import UIKit
import SwiftUI
import presentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let contentView = StartView()
        let onlogin = LoginSettings()
        
        // Use a UIHostingController as window root view controller.
        window = UIWindow()
        window?.rootViewController = UIHostingController(rootView: contentView.environmentObject(onlogin))
        window?.makeKeyAndVisible()
        
        return true
    }

}

struct StartView: View {
    @EnvironmentObject var settings: LoginSettings
    
    var body: some View {
        if UserDefaults.standard.bool(forKey: "isFirstView") {
            return AnyView(ContentView(appDI: AppDI()))
        } else {
            return AnyView(PMSView(appDI: AppDI(), loginVM: AppDI.shared.loginDependencies()))
        }
    }
}
