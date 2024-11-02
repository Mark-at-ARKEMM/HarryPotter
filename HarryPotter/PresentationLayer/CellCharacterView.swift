//
//  CellCharacterView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 03/11/2024.
//

import SwiftUI

struct CellCharacterView: View {
    let viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            CharacterImageView(url: viewModel.url)
                .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 0))
            VStack(alignment: .leading) {
                Text(viewModel.title).bold()
                Text(viewModel.detailText)
                Text(viewModel.yearOfBirth).font(.caption)
            }
            .padding(.top, 5)
            Spacer()
        }
    }
}

#Preview {
    CellCharacterView(viewModel: CellCharacterView.ViewModel(model: HPCharacter(id: UUID(), name: "Hermione Granger", alternateNames: [], species: "", gender: "", house: "", dateOfBirth: "", yearOfBirth: 1979, wizard: true, ancestry: "muggleborn", eyeColour: "", hairColour: "", wand: Wand(wood: "vine", core: "dragon heartstring", length: 10.75), patronus: "otter", hogwartsStudent: true, hogwartsStaff: false, actor: "Emma Watson", alternateActors: [], alive: true, image: "https://ik.imagekit.io/hpapi/hermione.jpeg")))
}
