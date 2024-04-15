//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Chip O'Connor on 3/27/24.
//
// This is the View - Card View Function

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
	var items: [Item]
	var aspectRatio: CGFloat = 1
	var content: (Item) -> ItemView

	init(_ items: [Item], aspectRatio: CGFloat,  @ViewBuilder content: @escaping (Item) -> ItemView) {
		self.items = items
		self.aspectRatio = aspectRatio
		self.content = content
	}

	var body: some View {
		GeometryReader { geometry in
			let gridItemSize = gridItemThatFits(
				count: items.count,
				size: geometry.size,
				atAspectRation: aspectRatio
			)
			LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
				ForEach(items) { item in
					content(item)
						.aspectRatio(aspectRatio, contentMode: .fit)
				}
			}

		}
	}

	private func gridItemThatFits (
		count: Int,
		size: CGSize,
		atAspectRation aspectRation: CGFloat) -> CGFloat {
			let count = CGFloat(count)
			var columnCount = 1.0
				//print("Grid size: \(size)")

			repeat {
				let width = size.width / columnCount
				let height = width / aspectRation

				let rowCount = (count / columnCount).rounded(.up)
				if rowCount * height < size.height {
					return (size.width / columnCount).rounded(.down)
				}
				columnCount += 1
			} while columnCount < count
			return min(size.width / count, size.height * aspectRation).rounded(.down)
		}
}
