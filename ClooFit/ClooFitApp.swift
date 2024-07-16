//
//  ClooFitApp.swift
//  ClooFit
//
//  Created by Claudio Sottile on 28/06/24.
//

import SwiftUI

@main
struct ClooFitApp: App {
    @StateObject private var closet = Closet()
    var body: some Scene {
        WindowGroup {
            WelcomePage()
                .environmentObject(closet)
        }
    }
}
