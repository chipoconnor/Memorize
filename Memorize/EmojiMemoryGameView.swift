//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Chip O'Connor on 11/3/22.
//
// This is the View

import SwiftUI

struct EmojiMemoryGameView: View {
	@ObservedObject var viewModel: EmojiMemoryGame

	private let cardAspectRatio: CGFloat = 2/3
	private let spacing: CGFloat = 4

	var body: some View {
		VStack {
			HStack {
				Text("Poppy's Game")
					.font(.largeTitle)
					.foregroundColor(.teal)
			}
			cards
				.foregroundColor(viewModel.color)
			Spacer()
			ButtonsView(viewModel)
		}
		.padding()
	}

	private var cards: some View {
		AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in CardView(card)
				.padding(spacing)
				.onTapGesture {
					viewModel.choose(card)
					viewModel.synthesizer.speak(card.content)
				}
		}
	}

}

struct EmojiMemoryGameView_Previews: PreviewProvider {
	static var previews: some View {
		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
			.preferredColorScheme(.dark)
//		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//			.preferredColorScheme(.light)
	}
}
