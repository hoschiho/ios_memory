//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pascal Hostettler on 02.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    @Environment(\.horizontalSizeClass) static var horizontalSizeClass
    @Published private var model: MemoryGame<String> = MemoryGameViewModel.createEmojiMemoryGame(difficulty: Difficulty.Easy)
        
    @Published var showingMenu = true
    
    private static func createEmojiMemoryGame(difficulty: Difficulty) -> MemoryGame<String> {
        let emojis: Array<String> = ["🌈","🧚‍♀️", "🦋","🧞‍♀️","👑"]
        return MemoryGame<String>(numberOfPairsOfCards: numbOfPairs(difficulty: difficulty)) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    static func numbOfPairs(difficulty: Difficulty) -> Int {
        if horizontalSizeClass == .compact {
            NSLog("compact")
            return 2
        } else {
            NSLog("gross")

            return 5
        }
    }
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func startGame(type: MemoryGameType, difficulty: Difficulty) {
        self.showingMenu = false

        switch type {
            case MemoryGameType.EmojiMemoryGame:
                model = MemoryGameViewModel.createEmojiMemoryGame(difficulty: difficulty)
                break
        }
    }
    
    func choose(card: MemoryGame<String>.Card){
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame() {
        model = MemoryGameViewModel.createEmojiMemoryGame(difficulty: Difficulty.Easy)
    }
}

public enum MemoryGameType {
    case EmojiMemoryGame
}

public enum Difficulty {
    case Easy
}
