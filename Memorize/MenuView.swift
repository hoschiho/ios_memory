//
//  MenuView.swift
//  Memorize
//
//  Created by Pascal Hostettler on 16.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: MemoryGameViewModel

    @State private var selectedGameType = MemoryGameType.EmojiMemoryGame
    @State private var selectedDifficulty = Difficulty.Easy
    
    var body: some View {
        VStack {
            Picker(selection: $selectedGameType, label: Text("GameType")) {
                Text("Emoji").tag(MemoryGameType.EmojiMemoryGame)
            }
            Picker(selection: $selectedDifficulty, label: Text("Difficulty")) {
                Text("Easy").tag(Difficulty.Easy)
            }
            Button(action: {
                viewModel.startGame(type: selectedGameType, difficulty: selectedDifficulty)
            }) {
                Text("Start Game")
            }

        }

    }
}













struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        MenuView(viewModel: game)
    }
}
