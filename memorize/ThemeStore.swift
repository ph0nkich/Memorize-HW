//
//  ThemeStore.swift
//  memorize
//
//  Created by Кирилл on 23.10.2025.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes: [Theme] = [
        Theme(name: "Sport", emojis: ["⚽️", "🏈", "🏀", "🎱"], numberOfPairs: 4, rgba: RGBA(color: .cyan)),
        Theme(name: "Cars", emojis: ["🚗", "🚒", "🚌", "🛵"], numberOfPairs: 4, rgba: RGBA(color: .red)),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🦊", "🐻"], numberOfPairs: 4, rgba: RGBA(color: .yellow)),
        Theme(name: "Electronic devices", emojis: ["⌚️", "📱", "💻", "🖨️"], numberOfPairs: 4, rgba: RGBA(color: .green)),
        Theme(name: "Hearts", emojis: ["💛", "❤️", "🩵", "💚"], numberOfPairs: 4, rgba: RGBA(color: .pink)),
        Theme(name: "Suits", emojis: ["♠︎", "♣︎", "♥︎", "♦︎"], numberOfPairs: 4, rgba: RGBA(color: .purple))
    ] {
        didSet {
            save()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Themes") {
            let decoder = JSONDecoder()
            if let decodedThemes = try? decoder.decode([Theme].self, from: data) {
                self.themes = decodedThemes
                return
            }
        }
    }
    
    func newTheme() -> Theme {
        let newTheme = Theme(name: "123", emojis: ["🚙", "♠︎", "🥲"], numberOfPairs: 3, rgba: RGBA(color: .black))
        themes.insert(newTheme, at: 0)
        return newTheme
    }
    
    func removeTheme( at offSet: IndexSet) {
        themes.remove(atOffsets: offSet)
    }
    
    private func save() {
        let jsonEncoder = JSONEncoder()
        if let encodedData = try? jsonEncoder.encode(themes) {
            UserDefaults.standard.set(encodedData, forKey: "Themes")
        }
    }
}

//#Preview {
//    ThemeStore()
//}
