//
//  ErrorView.swift
//  HarryPotter
//
//  Created by Mark Brindle on 10/11/2024.
//

import SwiftUI

struct ErrorMessage {
    enum Status {
        case information
        case warning
        case error
    }
    
    var errorType: Status
    var message: String
    
    public init(_ errorType: Status = .information, message: String) {
        self.errorType = errorType
        self.message = message
    }
    
    var color: Color {
        switch errorType {
        case .information: return .green
        case .warning: return .yellow
        case .error: return .red
        }
    }
}

struct ErrorView: View {
    @Environment(ApplicationData.self) private var appData
    
    @ViewBuilder
    var body: some View {
        if let errorMessage = appData.errorMessage {
            withAnimation {
                Text(errorMessage.message)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding([.top, .bottom])
                    .frame(maxWidth: .infinity)
                    .background(errorMessage.color)
                    .onTapGesture {
                        appData.errorMessage = nil
                    }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    
    ErrorView()
        .environment(ApplicationData())
}
