//
//  CardView.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/14/24.
//

import SwiftUI

struct CardView: View {
	typealias Card = MemoryGame<String>.Card

	let card: Card

	init(_ card: Card) {
		self.card = card
	}

//	var body: some View {
//		VStack {
//			Text(card.id)
//				.foregroundStyle(.yellow)
//				.font(.title)
//			Pie(endAngle: .degrees(-90))
//				.opacity(Constants.Pie.opacity)
//				.overlay(
//					Text(card.content)
//						.font(.system(size: Constants.FontSize.largest))
//						.minimumScaleFactor(Constants.FontSize.scaleFactor)
//						.multilineTextAlignment(.center)
//						.aspectRatio(1, contentMode: .fit)
//						.padding(Constants.Pie.inset)
//						.rotationEffect(.degrees(card.isMatched ? 360 : 0))
//						.animation(.spin(duration: 2), value: card.isMatched)
//				)
//				.padding(Constants.inset)
//				.cardify(isFaceUp: card.isFaceup)
//				.opacity(card.isFaceup || !card.isMatched ? 1 : 0)
//		}
//	}
	var body: some View {
		TimelineView(.animation) { timeline in
			if card.isFaceUp || !card.isMatched {
				Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
					.opacity(Constants.Pie.opacity)
					.overlay(cardContents.padding(Constants.Pie.inset))
					.padding(Constants.inset)
					.cardify(isFaceUp: card.isFaceUp)
					.transition(.scale)
			} else {
				Color.clear
			}
		}
	}

	var cardContents: some View {
		Text(card.content)
			.font(.system(size: Constants.FontSize.largest))
			.minimumScaleFactor(Constants.FontSize.scaleFactor)
			.multilineTextAlignment(.center)
			.aspectRatio(1, contentMode: .fit)
			.rotationEffect(.degrees(card.isMatched ? 360 : 0))
			.animation(card.isMatched ? .spin(duration: 1) : .default, value: card.isMatched)
	}
	private struct Constants {
		static let inset: CGFloat = 5
		struct FontSize {
			static let largest: CGFloat = 200
			static let smallest: CGFloat = 10
			static let scaleFactor = smallest / largest
		}
		struct Pie {
			static let opacity: CGFloat = 0.5
			static let inset: CGFloat = 5
		}
	}
}

extension Animation {
	static func spin(duration: TimeInterval) -> Animation {
		.linear(duration: duration).repeatForever(autoreverses: false)
	}
}

struct CardView_Previews: PreviewProvider {
	typealias Card = CardView.Card

	static var	previews: some View {
		VStack {
			HStack {
				CardView(Card(isFaceUp: true,content: "X",id: "X1"))
					.aspectRatio(4/3, contentMode: .fit)
				CardView(Card(isFaceUp: true,content: "X",id: "X2"))
			}
			HStack {
				CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string I hope fits", id: "Y1"))
				CardView(Card(isFaceUp: true, isMatched: true, content: "Y", id: "Y2"))
			}
		}
			.padding()
			.foregroundColor(.blue)
	}
	
}
