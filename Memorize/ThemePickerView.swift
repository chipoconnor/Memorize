//
//  ThemePickerView.swift
//  Memorize
//
//  Created by Chip O'Connor on 2/10/26.
//

import SwiftUI

struct ThemePickerView: View {
	let viewModel: EmojiMemoryGame
	@Binding var isPresented: Bool

	var body: some View {
		NavigationStack {
			List(Theme.allThemes) { theme in
				Button {
					withAnimation {
						viewModel.changeTheme(to: theme)
					}
					isPresented = false
				} label: {
					HStack(spacing: 16) {
						Image(systemName: theme.icon)
							.font(.title2)
							.foregroundStyle(theme.color)
							.frame(width: 36)

						VStack(alignment: .leading, spacing: 2) {
							Text(theme.name)
								.font(.headline)
								.foregroundStyle(.primary)
							Text(theme.emojis.prefix(6).joined())
								.font(.caption)
								.foregroundStyle(.secondary)
						}

						Spacer()

						if viewModel.currentTheme == theme {
							Image(systemName: "checkmark")
								.foregroundStyle(theme.color)
								.fontWeight(.semibold)
						}
					}
					.padding(.vertical, 4)
				}
			}
			.navigationTitle("Choose a Theme")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button("Done") {
						isPresented = false
					}
				}
			}
		}
		.presentationDetents([.medium, .large])
		.presentationDragIndicator(.visible)
	}
}
