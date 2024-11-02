//
//  CellSpellView+ViewModel.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//
import Foundation

extension CellSpellView {
    @Observable
    final class ViewModel {
        private let model: Spell
        
        var title: String { model.name }
        var detailText: String { model.description }
        
        init(model: Spell) {
            self.model = model
        }
    }
}
