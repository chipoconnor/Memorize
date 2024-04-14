//
//  MemoryGame.swift
//  Memorize
//
//  Created by Chip O'Connor on 3/7/24.
//
// This is the Model

import Foundation
import AVFoundation

struct MemoryGame<CardContent> where CardContent: Equatable {
	private(set) var cards: Array<Card>

	init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
		cards = []
			// add NumberOfPairsOfCards * 2 cards to cards array
		for pairIndex in 0..<max(2, numberOfPairsOfCards) {
			let content = cardContentFactory(pairIndex)
			let utterance = AVSpeechUtterance(string: (content as! String).lowercased())
			cards.append(Card(content: content,
							  spoken: utterance,
							  id: "\(pairIndex+1)a"))
			cards.append(Card(content: content, 
							  spoken: utterance,
							  id: "\(pairIndex+1)b"))
		}
		// shuffle so the pairs are not together in the array
		cards.shuffle()
	}

	private var indexOfTheOneAndOnlyFaceUpCard: Int? {
		get { cards.indices.filter { index in cards[index].isFaceup }.only }
		set { cards.indices.forEach { cards[$0].isFaceup = (newValue == $0)} }
	}

	mutating func choose(_ card: Card) {
		if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
			if !cards[chosenIndex].isFaceup && !cards[chosenIndex].isMatched {
				if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
					if cards[chosenIndex].content == cards[potentialMatchIndex].content {
						cards[chosenIndex].isMatched = true
						cards[potentialMatchIndex].isMatched = true
					}
				} else {
					indexOfTheOneAndOnlyFaceUpCard = chosenIndex
				}
				cards[chosenIndex].isFaceup = true
			}
		}
	}

	mutating func shuffle() {
		cards.shuffle()
	}

	struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
		var isFaceup = false
		var isMatched = false
		let content: CardContent
		let spoken: AVSpeechUtterance
		var id: String

		var debugDescription: String {
			"\(id): \(content) \(isFaceup ? "up" : "down") \(isMatched ? "matched" : "")"
		}
	}
}

extension Array {
	var only: Element? {
		count == 1 ? first : nil
	}
}
