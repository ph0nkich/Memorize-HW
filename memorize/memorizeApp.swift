//
//  memorizeApp.swift
//  memorize
//
//  Created by Кирилл on 30.09.2025.
//

import SwiftUI

@main
struct memorizeApp: App {
    @StateObject var store = ThemeStore()
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser(store: store)
        }
    }
}
