//
//  ContentView.swift
//  Memorize
//
//  Created by Chip O'Connor on 11/3/22.
//

import SwiftUI

struct ContentView: View {
	var emojis = ["🚔","🚌","🛻","🚇","🚗","🚆","🛺","🚀",
				  "🚁","🚂","⛵️","🛵","🚠","🏎️","🛰️","🚟",
				  "🌋","🗻","🎢","⚓️","🪝","⛽️","⛩️","🕌",
				  "🩼","🚨","🚍","🚡","🛸","🛶","🚧","🚢"]
	@State var emojiCount = 4

    var body: some View {
		VStack {
			Text("Memorize").font(.largeTitle)
			ScrollView {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
					ForEach(emojis[0..<emojiCount], id: \.self ) { emoji in
						CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
					}
				}
			}
			.foregroundColor(.red)
			Spacer()
			HStack {
				removeCard
				Spacer()
				addCard
			}
			.font(.largeTitle)
			.padding(.horizontal)
		}
		.padding(.horizontal)
    }

	var removeCard: some View {
		Button {
			if emojiCount > 1 {
				emojiCount -= 1
			}
		} label: {
			Image(systemName: "minus.circle")
		}
	}

	var addCard: some View {
		Button {
			if emojiCount < emojis.count {
				emojiCount += 1
			}
		} label: {
			Image(systemName: "plus.circle")
		}
	}
}

struct CardView: View {
	var content: String
	@State var isFaceUp: Bool = true

	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 20)
			if isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3)
				Text(content).font(.largeTitle)
			} else {
				shape.fill()
			}
		}
		.onTapGesture {
			isFaceUp = !isFaceUp
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
		ContentView()
			.preferredColorScheme(.light)
    }
}
