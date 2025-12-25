//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Chip O'Connor on 11/3/22.
//
// This is the View

import SwiftUI

struct EmojiMemoryGameView: View {
	typealias Card = MemoryGame<String>.Card

	@ObservedObject var viewModel: EmojiMemoryGame

	private let aspectRatio: CGFloat = 2/3
	private let spacing: CGFloat = 4
	private let dealAnimation: Animation = .easeInOut(duration: 1)
	private let dealInterval: TimeInterval = 0.15
	private let deckWidth: CGFloat = 50
	private let cardAspectRatio: CGFloat = 2/3
	
	private var titleGradient: AnyShapeStyle {
		if #available(iOS 16.0, *) {
			return AnyShapeStyle(viewModel.color.gradient)
		} else {
			return AnyShapeStyle(viewModel.color)
		}
	}

	var body: some View {
		VStack {
			HStack {
				Text("Poppy's Choice")
					.font(.largeTitle)
					.foregroundStyle(titleGradient)
				
				Spacer()
				
				VStack(alignment: .trailing) {
					Text(viewModel.currentTheme.name)
						.font(.headline)
						.foregroundStyle(.secondary)
					Text("Score: \(viewModel.score)")
						.font(.title2)
						.fontWeight(.bold)
						.foregroundStyle(viewModel.color)
				}
			}
			
			cards
				.foregroundColor(viewModel.color)
			
			Spacer()
			
			ButtonsView(viewModel)
		}
		.padding()
		.alert("Congratulations! 🎉", isPresented: .constant(viewModel.isGameComplete)) {
			Button("New Game") {
				withAnimation {
					viewModel.newGame()
				}
			}
			Button("Change Theme") {
				// The alert will dismiss and user can select theme
			}
		} message: {
			Text("You completed the game with a score of \(viewModel.score)!")
		}
	}

	private var cards: some View {
		AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
			CardView(card, themeIcon: viewModel.currentTheme.icon)
				.padding(spacing)
				.onTapGesture {
					withAnimation(.easeInOut(duration: 2)) {
						viewModel.choose(card)
					}
				}
		}
		.id(viewModel.gameId)  // Force view recreation on new game
	}

	private func view(for card: Card) -> some View {
		CardView(card, themeIcon: viewModel.currentTheme.icon)
			.matchedGeometryEffect(id: card.id, in: dealingNamespace)
			.transition(.asymmetric(insertion: .identity, removal: .identity))
	}

	private func choose(_ card: Card) {
		withAnimation {
			let scoreBeforeChoosing = viewModel.score
			viewModel.choose(card)
			let scoreChange = viewModel.score - scoreBeforeChoosing
			lastScoreChange = (scoreChange, causedByCardId: card.id)
		}
	}

	@State private var lastScoreChange = (0, causedByCardId: "")

	private func scoreChange(causedBy card: Card) -> Int {
		let (amount, id) = lastScoreChange
		return card.id == id ? amount : 0
	}

	// MARK: - Dealing from a Deck

	@State private var dealt = Set<Card.ID>()

	private func isDealt(_ card: Card) -> Bool {
		dealt.contains(card.id)
	}
	private var undealtCards: [Card] {
		viewModel.cards.filter { !isDealt($0) }
	}

	@Namespace private var dealingNamespace

	private var deck: some View {
		ZStack {
			ForEach(undealtCards) { card in
				view(for: card)
			}
		}
		.frame(width: deckWidth, height: deckWidth / aspectRatio)
		.onTapGesture {
			deal()
		}
	}

	private func deal() {
		var delay: TimeInterval = 0
		for card in viewModel.cards {
			withAnimation(dealAnimation.delay(delay)) {
				_ = dealt.insert(card.id)
			}
			delay += dealInterval
		}
	}
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
	static var previews: some View {
//		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//			.preferredColorScheme(.lignt)
		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
			.preferredColorScheme(.dark)
	}
}

