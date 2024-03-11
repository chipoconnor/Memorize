//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Chip O'Connor on 11/3/22.
//
// This is the app

import SwiftUI

@main
struct MemorizeApp: App {
	@StateObject var game = EmojiMemoryGame()
	
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
