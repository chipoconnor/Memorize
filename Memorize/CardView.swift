//
//  CardView.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/14/24.
//

import SwiftUI

struct CardView: View {
	typealias Card = MemoryGame<String>.Card

	let card: MemoryGame<String>.Card

	init(_ card: Card) {
		self.card = card
	}

	var body: some View {
		Pie(endAngel: .degrees(240))
			.opacity(Constants.Pie.opacity)
			.overlay(
				Text(card.content)
					.font(.system(size: Constants.FontSize.largest))
					.minimumScaleFactor(Constants.FontSize.scaleFactof)
					.multilineTextAlignment(.center)
					.aspectRatio(1, contentMode: .fit)
					.padding(Constants.Pie.inset)
			)
			.padding(Constants.inset)
			.cardify(isFaceUp: card.isFaceup)
			.opacity(card.isFaceup || !card.isMatched ? 1 : 0)
	}

	private struct Constants {
		static let inset: CGFloat = 5
		struct FontSize {
			static let largest: CGFloat = 200
			static let smallest: CGFloat = 10
			static let scaleFactof = smallest / largest
		}
		struct Pie {
			static let opacity: CGFloat = 0.5
			static let inset: CGFloat = 5
		}
	}
}

struct CardView_Previews: PreviewProvider {
	typealias Card = CardView.Card

	static var	previews: some View {
		VStack {
			HStack {
				CardView(Card(content: "X",
							  id: "X1"))
				CardView(Card(isFaceup: true,
							  content: "X",
							  id: "X2"))
			}
			HStack {
				CardView(Card(isFaceup: true,
							  content: "This is a very long string and I hope it fits",
							  id: "Y1"))
				CardView(Card(isMatched: true,
							  content: "Y",
							  id: "Y2"))
			}
		}
		.padding()
		.foregroundColor(.blue)
	}
	
}
