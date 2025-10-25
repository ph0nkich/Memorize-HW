//
//  ThemeChooser.swift
//  memorize
//
//  Created by Кирилл on 23.10.2025.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var store: ThemeStore
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                            HStack {
                                Text("\(theme.numberOfPairs) pairs")
                                Text("\(theme.emojis.joined())")
                            }
                        }
                    }
                    .foregroundStyle(Color(rgba: theme.rgba))
                }
                .onDelete { indexSet in
                    store.removeTheme(at: indexSet)
                }
            }
            .navigationTitle("Themes")
            .toolbar {
                Button(
                    action: { themeToEdit = store.newTheme() },
                    label: { Image(systemName: "plus") }
                )
            }
        }
        .sheet(item: $themeToEdit) { theme in
            if let index = store.themes.firstIndex(where: { $0.id == theme.id }) {
                ThemeEditor(theme: $store.themes[index])
            }
        }
    }
}

//#Preview {
//    ThemeChooser()
//}
