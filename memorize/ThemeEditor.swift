//
//  ThemeEditor.swift
//  memorize
//
//  Created by Кирилл on 24.10.2025.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    @State private var emojisToAdd = ""
    
    let columns = [GridItem(.adaptive(minimum: 40))]
    
    private var color: Binding<Color> {
        Binding (
            get: {
                Color(rgba: theme.rgba)
            },
            set: { newValue in
                theme.rgba = RGBA(color: newValue)
            }
        )
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Название темы", text: $theme.name)
            }
            Section {
                Stepper("\(theme.numberOfPairs) пар", value: $theme.numberOfPairs, in: 2...max(2, theme.emojis.count))
            }
            Section {
                LazyVGrid(columns: columns) {
                    ForEach(theme.emojis, id: \.self) { emoji in
                        Text(emoji)
                            .onTapGesture {
                                if let index = theme.emojis.firstIndex(where: { $0 == emoji }) {
                                    theme.emojis.remove(at: index)
                                }
                            }
                    }
                }
            }
            Section {
                TextField("Добавить эмодзи", text: $emojisToAdd)
                    .onChange(of: emojisToAdd) { value in
                        for emoji in value {
                            theme.emojis.append(String(emoji))
                        }
                        emojisToAdd = ""
                    }
            }
            Section {
                ColorPicker("Цвет", selection: color)
            }
        }
    }
}

//#Preview {
//    ThemeEditor()
//}
