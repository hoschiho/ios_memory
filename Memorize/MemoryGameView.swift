//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Pascal Hostettler on 29.10.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: MemoryGameViewModel

    var body: some View {
        VStack {
            Button(action: {
                self.viewModel.showingMenu = true
            }) {
                Text("New Game")
            }.sheet(isPresented: $viewModel.showingMenu) {
                MenuView(viewModel: self.viewModel)
            }
            Text("Score:  \(viewModel.score)")
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                    .padding(5)
            }

                .padding()
                .foregroundColor(Color.blue)
        }
        

    }
    

    
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
//                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90), clockwise: true)
//                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
                .cardify(isFaceUp: card.isFaceUp)


        }
    }
    
    


    //MARK: - Drawing Constants



    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        game.choose(card: game.cards[0])
        return MemoryGameView(viewModel: game)
    }
}
