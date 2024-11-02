//
//  AppLauncher.swift
//  HarryPotter
//
//  Created by Mark Brindle on 08/11/2024.
//

import Foundation
import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            HarryPotterApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

