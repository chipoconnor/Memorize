//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chip O'Connor on 3/7/24.
//
// This is the View Model

import SwiftUI

class EmojiMemoryGame: ObservableObject {
	private static let emojis: [String: Array] = [
		"Transport": [
						"🚌","🛻","🚗","🚀","🚁","🚂"
					   ,"⛵️","🛵","🏎️","🛰️","🌋","🗻","🎢","⚓️"
					  ],

		"Letters": 	[
					"A","B","C","D","E","F","G","H","I","J"
				   ,"K","L","M","N","O","P","Q","R","S","T"
				   ,"U","V","W","X","Y","Z"
				   ,"a","b","c","d","e","f","g","h","i","j"
					,"k","l","m","n","o","p","q","r","s","t"
					,"u","v","w","x","y","z"
					],

		"Numbers": [
					 "0.00","0.01","0.02","0.03","0.04"
					,"0","1","2","3","4","5","6","7","8","9"
					,"10","20"
					,"100","200"
					,"1000","2000"
				   ],

		"Food":		[
					"🥕","🍏","🥔","🍌","🥑","🥨","🍕","🫔","🌮","🥭"
					]
			]

	static var currentThemeName = "Numbers"

	private static func createMenoryGame(nameOfTheme: String) -> MemoryGame<String> {
		// shuffle, so each game is different
		if let emojiTheme = emojis[nameOfTheme]?.shuffled() {
			currentThemeName = nameOfTheme
			return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 4..<emojiTheme.count)) {
				pairIndex in
				if emojiTheme.indices.contains(pairIndex) {
					return emojiTheme[pairIndex]
				} else {
					return "⁉️"
				}
			}
		} else {
			return MemoryGame<String>(numberOfPairsOfCards: 0) { _ in return "⁉️\(nameOfTheme)" }
		}
	}

	@Published private var model =
				createMenoryGame(nameOfTheme: currentThemeName)

	var cards: Array<MemoryGame<String>.Card> {
		return model.cards
	}

	// MARK: - Intents

	func choose(_ card: MemoryGame<String>.Card) {
		model.choose(card)
	}

	func suffle() {
		model.shuffle()
//		print(model.cards)
	}

	func changeTheme(_ newTheme: String) {
		model = EmojiMemoryGame.createMenoryGame(nameOfTheme: newTheme)
	}
}
