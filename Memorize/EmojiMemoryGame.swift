//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pascal Hostettler on 02.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Environment(\.horizontalSizeClass) static var horizontalSizeClass
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    

    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🌈","🧚‍♀️", "🦋","🧞‍♀️","👑"]
        return MemoryGame<String>(numberOfPairsOfCards: numbOfPairs()) { pairIndex in
            return emojis[pairIndex]
        }
    }
    static func numbOfPairs() -> Int {
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
    
    func choose(card: MemoryGame<String>.Card){
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
