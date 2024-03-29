//
//  StoryboardtoUI.swift
//  SMS-V2
//
//  Created by jge on 2020/09/15.
//

import Foundation
import SwiftUI

 struct StoryboardtoUI: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let bundle = Bundle(identifier: "com.jeonggo.presentation")
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let controller = storyboard.instantiateViewController(identifier: "Main")
        return controller as! ViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

 }
