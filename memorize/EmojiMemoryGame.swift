//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Кирилл on 05.10.2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    var score: Int {
        model.score
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var currentTheme: Theme
    
    var color: Color {
        .orange
    }
    
    init(theme: Theme) {
        self.currentTheme = theme
        self.model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    
}
