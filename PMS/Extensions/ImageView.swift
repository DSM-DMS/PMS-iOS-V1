////
////  ImageView.swift
////  PMS
////
////  Created by GoEun Jeong on 2021/04/05.
////  Copyright © 2021 jge. All rights reserved.
////
//
// import SwiftUI
//
// struct ImageView: View {
//
//    let url: String
//    @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()
//
//    init(url: String) {
//        self.url = url
//        self.imageDownloader.downloadImage(url: self.url)
//    }
//
//    var body: some View {
//        if let imageData = self.imageDownloader.downloadedData {
//            let img = UIImage(data: imageData)
//            return VStack {
//                Image(uiImage: img!)
//                    .resizable()
//            }
//        } else {
//            return VStack {
//                Image(systemName: "rayss")
//                    .resizable()
//            }
//        }
//    }
// }
//
// class ImageDownloader: ObservableObject {
//    @Published var downloadedData: Data?
//
//    func downloadImage(url: String) {
//        guard let imageURL = URL(string: url) else {
//            fatalError("Invalid URL")
//        }
//
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: imageURL)
//            DispatchQueue.main.async {
//                self.downloadedData = data
//            }
//        }
//    }
// }
