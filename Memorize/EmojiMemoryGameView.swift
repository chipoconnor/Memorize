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

	var body: some View {
		VStack {
			Text("Memorize")
				.font(.largeTitle)
				.foregroundColor(.teal)
			ScrollView {
				cards
					.animation(.default, value: viewModel.cards)
			}
			Spacer()
			HStack {
				VStack {
					Image(systemName: "airplane.departure")
						.foregroundColor(.yellow)
					Button("Transport") {
						viewModel.changeTheme("Transport")
					}
				}
				Spacer()
				VStack {
					Image(systemName: "a.square")
						.foregroundColor(.yellow)
					Button("Letters") {
						viewModel.changeTheme("Letters")
					}
				}
				Spacer()
				VStack {
					Image(systemName: "123.rectangle")
						.foregroundColor(.yellow)
					Button("Numbers") {
						viewModel.changeTheme("Numbers")
					}
				}
			}
			.foregroundColor(.green)
			.font(.title2)
		}
		.padding()
	}

	var cards: some View {
		LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
				ForEach(viewModel.cards) { card in CardView(card)
						.aspectRatio(2/3, contentMode: .fit)
						.padding(4)
						.onTapGesture {
							viewModel.choose(card)
							if !card.isFaceup {
								let utterance = AVSpeechUtterance(string: card.content)
								//utterance.voice = AVSpeechSynthesisVoice(language: "en-IE")
								EmojiMemoryGameView.synthesizer.speak(utterance)
							}
						}
				}
		}
		.foregroundColor(.blue)
	}
}

struct CardView: View {
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
