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

	init(viewModel: EmojiMemoryGame) {
		self.viewModel = viewModel
	}

	private let cardAspectRatio: CGFloat = 2/3
	private let spacing: CGFloat = 4

	var body: some View {
		VStack {
			HStack {
				Text("Poppy's Game")
				Spacer()
				Text("Score: \(viewModel.score)")
			}
			.font(.largeTitle)
			.foregroundColor(.teal)
			cards
				.foregroundColor(viewModel.color)
			Spacer()
			//shuffle
			ButtonsView(viewModel)
		}
		.padding()
	}

//	private var shuffle: some View {
//		VStack {
//			Button("shuffle", systemImage: "shuffle") {
//				withAnimation { viewModel.suffle()	}
//			}
//			.labelStyle(.iconOnly)
//			.foregroundColor(.yellow)
//			.font(.largeTitle)
//		}
//	}

	private var cards: some View {
		AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
			CardView(card)
				.padding(spacing)
				.onTapGesture {
					withAnimation(.easeInOut(duration: 2)) {
						viewModel.choose(card)
					}
					viewModel.synthesizer.speak(card.content)
//					print(card.debugDescription)
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
