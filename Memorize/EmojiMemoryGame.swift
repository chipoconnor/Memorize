//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chip O'Connor on 3/7/24.
//
// This is the View Model

import SwiftUI

class EmojiMemoryGame: ObservableObject {

	static var currentThemeName = "Letters"

	var synthesizer = Speaker()

	@Published private var model: MemoryGame<String>

	init(synthesizer: Speaker = Speaker(), model: MemoryGame<String> = createMemoryGame()) {
		self.synthesizer = synthesizer
		self.model = model
	}

	private static let emojis: [String: Array] = [
		"Transport": [
					"🚌","🛻","🚗","🚀","🚁","🚂"
					,"⛵️","🛵","🏎️","🛰️","🌋","🗻","🎢","⚓️"
					  ],

		"Letters": 	[
					"A a","B b","C c","D d","E e","F f","G g","H h","I i","J j"
					,"K k","L l","M m","N n","O o","P p","Q q","R r","S s","T t"
					,"U u","V v","W w","X x","Y y","Z z"

					],

		"Numbers": [
					 "0","1","2","3","4","5","6","7","8","9"
//					,"10","20"
//					,"100","200"
//					,"1000","2000"
//					,"0.00","0.01","0.02","0.03","0.04"
				   ],

		"Food":		[
					"🥕","🍏","🥔","🍌","🥑","🥨","🍕","🫔","🌮","🥭"
					]
			]

	private static func createMemoryGame() -> MemoryGame<String> {
			// get a random key from the emojis dictionary
			// currentThemeName = emojis.keys.randomElement()!
		// shuffle, so each game is different
		if let emojiTheme = emojis[currentThemeName]?.shuffled() {
			return MemoryGame<String>(numberOfPairsOfCards: 
							// the MIN between 4 and the number of elements in the array
							min(Int.random(in: 4..<emojiTheme.count), 6)) {
				pairIndex in
				if emojiTheme.indices.contains(pairIndex) {
					return emojiTheme[pairIndex]
				} else {
					return "⁉️"
				}
			}
		} else {
			return MemoryGame<String>(numberOfPairsOfCards: 0) { _ in return "⁉️\(currentThemeName)" }
		}
	}

	var cards: Array<MemoryGame<String>.Card> {
		model.cards
	}

	var color: Color {
		.blue
	}

	var score: Int {
		model.score
	}

	// MARK: - Intents

	func choose(_ card: MemoryGame<String>.Card) {
		model.choose(card)
	}

	func suffle() {
		model.shuffle()
	}

	func changeTheme(_ newTheme: String)  {
		EmojiMemoryGame.currentThemeName = newTheme
		self.model = EmojiMemoryGame.createMemoryGame()
	}
}
