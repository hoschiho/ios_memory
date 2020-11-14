//
//  ContentView.swift
//  Memorize
//
//  Created by Pascal Hostettler on 29.10.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.blue)
            .font(Font.largeTitle)
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white).aspectRatio(0.67, contentMode: .fit)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3).aspectRatio(0.67, contentMode: .fit)
                    Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill().aspectRatio(0.67, contentMode: .fit)

            }
            
        }
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
