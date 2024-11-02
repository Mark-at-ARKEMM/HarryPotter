//
//  CharacterImageView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 05/11/2024.
//

import SwiftUI

struct CharacterImageView: View {
    let url: URL?
    
    private let cornerRadius: CGFloat = 8
    private let frameWidth: CGFloat = 80
    private let frameHeight: CGFloat = 100
    
    var body: some View {
        if url == nil {
            Image("SortingHat")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.brown)
                .cornerRadius(cornerRadius)
                .frame(width: frameWidth, height: frameHeight)
        } else {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Image("SortingHat")
                        .renderingMode(.template)
                } else {
                    ProgressView()
                }
            }
            .cornerRadius(cornerRadius)
            .frame(width: frameWidth, height: frameHeight)
        }
    }
}

#Preview {
    CharacterImageView(url: nil)
}
