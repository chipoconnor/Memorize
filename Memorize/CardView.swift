//
//  CardView.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/14/24.
//

import SwiftUI
import AVFoundation

struct CardView: View {
	typealias Card = MemoryGame<String>.Card

	let card: MemoryGame<String>.Card

	init(_ card: Card) {
		self.card = card
	}

	var body: some View {
		ZStack {
			let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
			Group {
				base.fill(.white)
				base.strokeBorder(lineWidth: Constants.lineWidth)
				Text(card.content)
					.font(.system(size: Constants.FontSize.largest))
					.minimumScaleFactor(Constants.FontSize.scaleFactof)
					.multilineTextAlignment(.center)
					.aspectRatio(contentMode: .fit)
					.padding(Constants.inset)
			}
			.opacity(card.isFaceup ? 1 : 0)
			base.fill()
				.opacity(card.isFaceup ? 0 : 1)
		}
		.opacity(card.isFaceup || !card.isMatched ? 1 : 0)
	}

	private struct Constants {
		static let cornerRadius: CGFloat = 12
		static let lineWidth: CGFloat = 2
		static let inset: CGFloat = 5
		struct FontSize {
			static let largest: CGFloat = 200
			static let smallest: CGFloat = 10
			static let scaleFactof = smallest / largest
		}
	}
}

struct CardView_Previews: PreviewProvider {
	typealias Card = CardView.Card

	static var	previews: some View {
		VStack {
			HStack {
				CardView(Card(content: "X",
							  spoken: AVSpeechUtterance(string: ("X").lowercased()),
							  id: "X1"))
				CardView(Card(isFaceup: true,
							  content: "X",
							  spoken: AVSpeechUtterance(string: ("X").lowercased()),
							  id: "X2"))
			}
			HStack {
				CardView(Card(isFaceup: true,
							  content: "This is a very long string and I hope it fits",
							  spoken: AVSpeechUtterance(string: ("Y").lowercased()),
							  id: "Y1"))
				CardView(Card(isMatched: true,
							  content: "Y",
							  spoken: AVSpeechUtterance(string: ("Y").lowercased()),
							  id: "Y2"))
			}
		}
		.padding()
		.foregroundColor(.blue)
	}
	
}
