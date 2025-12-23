//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chip O'Connor on 3/7/24.
//
// This is the View Model

import SwiftUI

class EmojiMemoryGame: ObservableObject {
	typealias Card = MemoryGame<String>.Card
	
	@Published private var model: MemoryGame<String>
	@Published private(set) var currentTheme: Theme
	@Published private(set) var gameId = UUID()
	
	var synthesizer = Speaker()
	
	init(theme: Theme = .letters) {
		self.currentTheme = theme
		self.model = EmojiMemoryGame.createMemoryGame(with: theme)
	}

	private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
		let shuffledEmojis = theme.emojis.shuffled()
		let numberOfPairs = min(theme.numberOfPairs, shuffledEmojis.count)
		
		return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
			if shuffledEmojis.indices.contains(pairIndex) {
				return shuffledEmojis[pairIndex]
			} else {
				return "⁉️"
			}
		}
	}

	var cards: Array<Card> {
		model.cards
	}

	var color: Color {
		currentTheme.color
	}

	var score: Int {
		model.score
	}
	
	var isGameComplete: Bool {
		cards.allSatisfy { $0.isMatched }
	}

	// MARK: - Intents

	func shuffle() {
		model.shuffle()
	}

	func choose(_ card: Card) {
		let cardIndex = model.cards.firstIndex(where: { $0.id == card.id })
		let wasAlreadyFaceUp = cardIndex.map { model.cards[$0].isFaceUp } ?? true
		
		model.choose(card)
		
		if !wasAlreadyFaceUp, let index = cardIndex, model.cards[index].isFaceUp {
			synthesizer.speak(card.content)
		}
	}

	func changeTheme(to newTheme: Theme) {
		currentTheme = newTheme
		model = EmojiMemoryGame.createMemoryGame(with: newTheme)
		gameId = UUID()
	}
	
	func newGame() {
		model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
		gameId = UUID()
	}
}



