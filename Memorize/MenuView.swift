//
//  MenuView.swift
//  Memorize
//
//  Created by Pascal Hostettler on 16.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    let view = EmojiMemoryGameView(viewModel: EmojiMemoryGame())

    var body: some View {
        VStack {
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("GameType")) {
                Text("Emoji").tag(1)
                Text("Contacts").tag(2)
                Text("Images").tag(3)
            }
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Difficulty")) {
                Text("Easy").tag(1)
                Text("Medium").tag(2)
                Text("Hard").tag(3)
            
            
        }

        }

    }
}













struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
