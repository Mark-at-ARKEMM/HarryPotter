//
//  ApplicationData.swift
//  HarryPotter
//
//  Created by Mark Brindle on 10/11/2024.
//

import SwiftUI
import Observation

@Observable class ApplicationData: @unchecked Sendable {
    var errorMessage: ErrorMessage?
    
    func errorView() -> some View {
        ErrorView()
    }
}
