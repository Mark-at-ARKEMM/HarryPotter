//
//  CellCharacterView+ViewModel.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation

extension CellCharacterView {
    @Observable
    final class ViewModel {
        private let model: HPCharacter
        
        var url: URL? { URL(string: model.image) }
        var title: String { model.name }
        var detailText: String { model.actor }
        var yearOfBirth: String {
            if let yr = model.yearOfBirth {
                return String(yr)
            }
            return ""
        }
        
        init(model: HPCharacter) {
            self.model = model
        }
    }
}
