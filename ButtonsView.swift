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
			Button("Shuffle", systemImage: "shuffle") {
				withAnimation { 
					viewModel.shuffle()
				}
			}
			Spacer()
			
			ForEach(Theme.allThemes) { theme in
				Button(theme.name, systemImage: theme.icon) {
					withAnimation {
						viewModel.changeTheme(to: theme)
					}
				}
				.foregroundColor(viewModel.currentTheme == theme ? .white : .yellow)
				.opacity(viewModel.currentTheme == theme ? 1.0 : 0.7)
				
				if theme != Theme.allThemes.last {
					Spacer()
				}
			}
		}
		.labelStyle(.iconOnly)
		.font(.largeTitle)
	}
}

