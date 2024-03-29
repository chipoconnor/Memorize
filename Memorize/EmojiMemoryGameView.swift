//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Chip O'Connor on 11/3/22.
//
// This is the View

import SwiftUI
import AVFoundation

struct EmojiMemoryGameView: View {
	@ObservedObject var viewModel: EmojiMemoryGame
	static let synthesizer = AVSpeechSynthesizer()

	private let aspectRatio: CGFloat = 2/3

	var body: some View {
		VStack {
			HStack {
				Text("Poppy's Game")
					.font(.largeTitle)
					.foregroundColor(.teal)
			}
			cards
				.animation(.default, value: viewModel.cards)
			Spacer()
			buttons
		}
		.padding()
	}

	private var cards: some View {
		AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in CardView(card)
				.padding(4)
				.onTapGesture {
					viewModel.choose(card)
					EmojiMemoryGameView.synthesizer.speak(card.spoken)
				}
				.foregroundColor(.blue)
		}
	}

	private var buttons: some View {
		HStack {
			VStack {
				Button("shuffle", systemImage: "shuffle",
					   action: { viewModel.suffle()	})
				.labelStyle(.iconOnly)
				.foregroundColor(.yellow)
			}
			Spacer()
			VStack {
				let theme = "Transport"
				Button("Transport", systemImage: "airplane.departure",
					   action: { viewModel.changeTheme(theme)})
				.labelStyle(.iconOnly)
				.foregroundColor(.yellow)
			}
			Spacer()
			VStack {
				let theme = "Letters"
				Button("Letters", systemImage: "a.square",
					   action: { viewModel.changeTheme(theme)})
				.labelStyle(.iconOnly)
				.foregroundColor(.yellow)
			}
			Spacer()
			VStack {
				let theme = "Numbers"
				Button("Numbers", systemImage: "123.rectangle",
					   action: { viewModel.changeTheme(theme)})
				.labelStyle(.iconOnly)
				.foregroundColor(.yellow)
			}
			Spacer()
			VStack {
				let theme = "Food"
				Button("Food", systemImage: "fork.knife",
					   action: { viewModel.changeTheme(theme)})
				.labelStyle(.iconOnly)
				.foregroundColor(.yellow)
			}
		}
		.foregroundColor(.green)
		.font(.title2)
	}
}


private struct CardView: View {
	let card: MemoryGame<String>.Card

	init(_ card: MemoryGame<String>.Card) {
		self.card = card
	}

	var body: some View {
		ZStack {
			let base = RoundedRectangle(cornerRadius: 12)
			Group {
				base.fill(.white)
				base.strokeBorder(lineWidth: 2)
				Text(card.content)
					.font(.system(size: 200))
					.minimumScaleFactor(0.01)
					.aspectRatio(contentMode: .fit)
			}
				.opacity(card.isFaceup ? 1 : 0)
			base.fill()
				.opacity(card.isFaceup ? 0 : 1)
		}
		.opacity(card.isFaceup || !card.isMatched ? 1 : 0)
	}
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
	static var previews: some View {
		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
			.preferredColorScheme(.dark)
		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
			.preferredColorScheme(.light)
	}
}
