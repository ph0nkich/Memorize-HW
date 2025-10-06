//
//  memorizeApp.swift
//  memorize
//
//  Created by Кирилл on 30.09.2025.
//

import SwiftUI

@main
struct memorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
