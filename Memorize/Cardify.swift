//
//  Cardify.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/15/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
	var themeIcon: String?

	init(isFaceUp: Bool, themeIcon: String? = nil) {
		rotation = isFaceUp ? 0 : 180
		self.themeIcon = themeIcon
	}
	
	var isFaceUp: Bool {
		rotation < 90
	}

	var rotation: Double

	var animatableData: Double {
		get { rotation }
		set { rotation = newValue }
	}

	func body(content: Content) -> some View {
		ZStack {
			let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
			// Front of card
			base.strokeBorder(lineWidth: Constants.lineWidth)
				.background(base.fill(.white))
				.overlay(content)
				.opacity(isFaceUp ? 1 : 0)
			// Back of card with enhanced design
			base.fill()
				.overlay(
					cardBackDesign
				)
				.opacity(isFaceUp ? 0 : 1)
		}
		.rotation3DEffect(.degrees(rotation), axis: (0,1,0))
	}

	// MARK: - Usage Instructions
	/*
	 Alternative card back designs for inspiration

	 See the Cardify extensions in CardBackDesignOptions.swift
	 for options of different Card backs.
	 Possibilities are:
		diamondPattern
		spiralPattern
		stripedPattern
		cornerIconsPattern
		shimmerPattern
	*/
	@ViewBuilder
	private var cardBackDesign: some View {
		diamondPattern
	}

	struct Constants {
		static let cornerRadius: CGFloat = 12
		static let lineWidth: CGFloat = 2
	}
}

extension View {
	func cardify(isFaceUp: Bool, themeIcon: String? = nil) -> some View {
		modifier(Cardify(isFaceUp: isFaceUp, themeIcon: themeIcon))
	}
}
