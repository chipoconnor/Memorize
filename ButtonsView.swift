//
//  ButtonsView.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/14/24.
//

import SwiftUI

struct ButtonsView: View {
	let viewModel: EmojiMemoryGame

	init(_ viewModel: EmojiMemoryGame) {
		self.viewModel = viewModel
	}

    var body: some View {
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

//#Preview {
//	ButtonsView( <#EmojiMemoryGame#>)
//}
