//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Кирилл on 05.10.2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
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
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    private let themes: [Theme<String>] = [
        Theme(name: "Sport", emojis: ["⚽️", "🏈", "🏀", "🎱"], numberOfPairs: 4, colorName: .blue),
        Theme(name: "Cars", emojis: ["🚗", "🚒", "🚌", "🛵"], numberOfPairs: 4, colorName:.red),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🦊", "🐻"], numberOfPairs: 4, colorName: .yellow),
        Theme(name: "Electronic devices", emojis: ["⌚️", "📱", "💻", "🖨️"], numberOfPairs: 4, colorName: .green),
        Theme(name: "Hearts", emojis: ["💛", "❤️", "🩵", "💚"], numberOfPairs: 4, colorName: .pink),
        Theme(name: "Suits", emojis: ["♠︎", "♣︎", "♥︎", "♦︎"], numberOfPairs: 4, colorName: .purple)
    ]
    
    enum ThemeColor: String {
        case blue, red, yellow, green, pink, purple
        
        var color: Color {
            switch self {
            case .blue: return .blue
            case .red: return .red
            case .yellow: return .yellow
            case .green: return .green
            case .pink: return .pink
            case .purple: return .purple
            }
        }
    }
    
    var currentTheme: Theme<String>
    
    init() {
        if let theme = themes.randomElement() {
            currentTheme = theme
            model = EmojiMemoryGame.createMemoryGame(with: theme)
        } else {
            let errorTheme = Theme<String>(name: "Error", emojis: ["⁉️"], numberOfPairs: 1, colorName: .red)
            currentTheme = errorTheme
            model = EmojiMemoryGame.createMemoryGame(with: errorTheme)
        }
    }
    
    func newGame() {
        if let theme = themes.randomElement() {
            currentTheme = theme
            model = EmojiMemoryGame.createMemoryGame(with: theme)
        }
    }
    
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    struct Theme<CardContent> {
        let name: String
        let emojis: [CardContent]
        let numberOfPairs: Int
        let colorName: ThemeColor
    }
    
}
