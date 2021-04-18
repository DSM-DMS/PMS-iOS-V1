//
//  ImageDetailView.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/04.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    var url: String
    
    @State var scale: CGFloat = 1.0
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        VStack {
            KFImage(URL(string: url)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIFrame.UIWidth)
                .scaleEffect(scale)
                .pinchToZoom()
                .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                .gesture(DragGesture()
                            .onChanged { value in
                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                            }
                            .onEnded { value in
                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                                self.newPosition = self.currentPosition
                            })
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(url: "")
    }
}
