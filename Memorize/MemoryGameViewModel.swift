//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pascal Hostettler on 02.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame<String> = MemoryGameViewModel.createEmojiMemoryGame(sizeClass: UserInterfaceSizeClass.regular, difficulty: Difficulty.Easy)
        
    @Published var showingMenu = true
    
    private static func createEmojiMemoryGame(sizeClass: UserInterfaceSizeClass, difficulty: Difficulty) -> MemoryGame<String> {
        let emojis: Array<String> = ["🌈","🧚‍♀️", "🦋","🧞‍♀️","👑","💍","🔮","🏺","📿","🕍","🕌","🏵"]
        return MemoryGame<String>(numberOfPairsOfCards: numbOfPairs(sizeClass: sizeClass, difficulty: difficulty)) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    static func numbOfPairs(sizeClass: UserInterfaceSizeClass, difficulty: Difficulty) -> Int {
        
        switch difficulty {
        case .Easy:
                if sizeClass == UserInterfaceSizeClass.compact {
                    NSLog("compact")
                    return 2
                } else {
                    NSLog("gross")
                    return 4
                }
            
        case .Medium:
                if sizeClass == UserInterfaceSizeClass.compact {
                    NSLog("compact")
                    return 6
                } else {
                    NSLog("gross")
                    return 10
                }
            
        case .Hard:
                if sizeClass == UserInterfaceSizeClass.compact {
                    NSLog("compact")
                    return 8
                } else {
                    NSLog("gross")
                    return 12
                }
            }

    }
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func startGame(sizeClass: UserInterfaceSizeClass, type: MemoryGameType, difficulty: Difficulty) {
        self.showingMenu = false

        switch type {
            case MemoryGameType.EmojiMemoryGame:
                model = MemoryGameViewModel.createEmojiMemoryGame(sizeClass: sizeClass, difficulty: difficulty)
                break
        }
    }
    
    func choose(card: MemoryGame<String>.Card){
        objectWillChange.send()
        model.choose(card: card)
    }
    
}

public enum MemoryGameType {
    case EmojiMemoryGame
}

public enum Difficulty {
    case Easy
    case Medium
    case Hard
}
