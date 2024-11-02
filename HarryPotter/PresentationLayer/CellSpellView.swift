//
//  CellSpellView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation
import SwiftUI

struct CellSpellView: View {
    let viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "wand.and.stars.inverse")
                .resizable()
                .frame(width: 80, height: 100)
                .padding(EdgeInsets(top: 9, leading: 8, bottom: 0, trailing: 0))
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.title).bold()
                Text(viewModel.detailText)
                Spacer()
            }.padding(.top, 5)
            Spacer()
        }
    }
}

#Preview {
    CellSpellView(viewModel: CellSpellView.ViewModel(model: Spell(id: UUID(), name: "Geminio", description: "Duplicates objects")))
}

