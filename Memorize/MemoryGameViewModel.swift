//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pascal Hostettler on 02.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI
import Combine


class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame<String> = MemoryGame()


    @Published var showingMenu = true

    private static func createEmojiMemoryGame(isPad: Bool, difficulty: Difficulty) -> MemoryGame<String> {
        let number = Int.random(in: 0...2)
        let emojis: Array<Array<String>> = [["🌝","🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔", "🌚", "🌜", "🌛"],
            ["🔮", "🧿", "🌙", "🍄", "🌶", "💎", "🖤", "🧙‍♀️", "🧝‍♀️", "🌿", "🕯", "✨"], ["🐌", "🐛", "🦗", "🦎", "🐢", "🦂", "🦟", "🕷", "🦐", "🦀", "🐀", "🦔"]]

        return MemoryGame<String>(numberOfPairsOfCards: numbOfPairs(isPad: isPad, difficulty: difficulty)) { pairIndex in
            return emojis[number][pairIndex]
        }
    }
    private func createUnsplashMemoryGame(isPad: Bool, difficulty: Difficulty) {
        let request = URL(string: "https://api.unsplash.com/photos/random/?client_id=P2j7aN1Y40nlIrLjbQm_EezeBZRZjBfAgNijHFle1Kk&count=12")!

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
            }
            guard let data = data else {
                fatalError("Error: missing response data")
            }

            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode([UnsplashImage].self, from: data)
                self.model = MemoryGame<String>(numberOfPairsOfCards: MemoryGameViewModel.numbOfPairs(isPad: isPad, difficulty: difficulty)) { pairIndex in
                return results[pairIndex].urls.thumb}
                print(results.map { $0.id })
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
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
        case MemoryGameType.UnsplashMemoryGame:
            createUnsplashMemoryGame(isPad: isPad, difficulty: difficulty)
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
    case UnsplashMemoryGame
}

public enum Difficulty {
    case Easy
    case Medium
    case Hard
}
