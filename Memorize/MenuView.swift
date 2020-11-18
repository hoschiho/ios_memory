//
//  MenuView.swift
//  Memorize
//
//  Created by Pascal Hostettler on 16.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @ObservedObject var viewModel: MemoryGameViewModel

    @State private var selectedGameType = MemoryGameType.EmojiMemoryGame
    @State private var selectedDifficulty = Difficulty.Easy
    
    let HighScore = UserDefaults.standard.integer(forKey: "HighScore")
    
    var body: some View {
        VStack {
            Text("HighScore: \(HighScore)")

            Picker(selection: $selectedGameType, label: Text("GameType")) {
                Text("Emoji").tag(MemoryGameType.EmojiMemoryGame)
            }
            Picker(selection: $selectedDifficulty, label: Text("Difficulty")) {
                Text("Easy").tag(Difficulty.Easy)
                Text("Medium").tag(Difficulty.Medium)
                Text("Hard").tag(Difficulty.Hard)
            }
            Button(action: {
                self.viewModel.startGame(sizeClass: self.horizontalSizeClass ?? UserInterfaceSizeClass.regular, type: self.selectedGameType, difficulty: self.selectedDifficulty)
            }) {
                Text("Start Game")
            }

        }

    }
}













struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        return MenuView(viewModel: game)
    }
}
