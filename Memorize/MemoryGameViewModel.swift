//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pascal Hostettler on 02.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame<String> = MemoryGameViewModel.createEmojiMemoryGame(isPad: false, difficulty: Difficulty.Easy)

    @Published var showingMenu = true

    private static func createEmojiMemoryGame(isPad: Bool, difficulty: Difficulty) -> MemoryGame<String> {
        let number = Int.random(in: 0...2)
        let emojis: Array<Array<String>> = [["🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔", "🌚", "🌜", "🌛"],
            ["🔮", "🧿", "🌙", "🍄", "🌶", "💎", "🖤", "🧙‍♀️", "🧝‍♀️", "🌿", "🕯", "✨"], ["🐌", "🐛", "🦗", "🦎", "🐢", "🦂", "🦟", "🕷", "🦐", "🦀", "🐀", "🦔"]]

        return MemoryGame<String>(numberOfPairsOfCards: numbOfPairs(isPad: isPad, difficulty: difficulty)) { pairIndex in
            return emojis[number][pairIndex]
        }
    }

    static func numbOfPairs(isPad: Bool, difficulty: Difficulty) -> Int {

        switch difficulty {
        case .Easy:
            if isPad == false {
                return 2
            } else {
                return 3
            }

        case .Medium:
            if isPad == false {
                return 4
            } else {
                return 8
            }

        case .Hard:
            if isPad == false {
                return 9
            } else {
                return 12
            }
        }

    }

    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    var score: Int {
        return model.score
    }

    var cardsInGame: Int {
        return model.cardsInGame
    }

    var won: Bool {
        return model.won
    }

    // MARK: - Intent(s)
    func startGame(isPad: Bool, type: MemoryGameType, difficulty: Difficulty) {
        self.showingMenu = false

        switch type {
        case MemoryGameType.EmojiMemoryGame:
            model = MemoryGameViewModel.createEmojiMemoryGame(isPad: isPad, difficulty: difficulty)
            break
        }
    }

    func choose(card: MemoryGame<String>.Card) {
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
