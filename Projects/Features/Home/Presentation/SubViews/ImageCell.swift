//
//  ImageCell.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/29/25.
//

import SwiftUI

struct ImageCell: View {
    var onDeleteTap: () -> Void
    var uiImage: UIImage
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 170)
                .cornerRadius(10)
                .clipped()
            
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.white, .black)
                .background(
                    Circle().fill(.black.opacity(0.6))
                )
                .offset(x: 6, y: -6)
                .onTapGesture {
                    onDeleteTap()
                }
        }
        .frame(width: 200, height: 200)
    }
}
