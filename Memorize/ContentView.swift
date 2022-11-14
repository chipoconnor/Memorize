//
//  ContentView.swift
//  Memorize
//
//  Created by Chip O'Connor on 11/3/22.
//

import SwiftUI

struct ContentView: View {

	let initialCount = 5

	@State var emojiCount = 5
		/* this is the startup array of emojis; throw in shuffled() so it is not the same for every startup	*/
	@State var emojis = ["🚔","🚌","🛻","🚇","🚗","🚆","🛺","🚀",
						 "🚁","🚂","⛵️","🛵","🚠","🏎️","🛰️","🚟",
						 "🌋","🗻","🎢","⚓️","🪝","⛽️","⛩️","🕌",
						 "🩼","🚨","🚍","🚡","🛸","🛶","🚧","🚢"]
			.shuffled()
		/* the next three arrays are selected by button actions on the bottom of the display.  they are "themes" of varing length. */
		let travelEmojis = ["🛺", "🚖", "🚂", "✈️", "🦽", "🚔",
							"🚗", "🏎", "🚙", "🚠", "🛶", "🚡",
							"🛻", "🚁", "🚤", "⚓️", "🪝", "🛳",
							"⛴", "🚧", "🚦", "🚥", "⛽️", "🚢"]
		let foodEmojis = ["🍏", "🍎", "🍆", "🥨", "🍒", "🥦",
						  "🥐", "🍟", "🌭", "🍔", "🍤", "🍧"]
		let mathEmojis = ["∞", "∇", "∏", "℮", "ℏ", "∫","∂", "∑", "∲"]

    var body: some View {
			VStack {
				Text("Memorize").font(.largeTitle)
				GeometryReader { geometry in
					ScrollView {
							// the bestFitFrame function is for Extra Credit # 2
							// it returns the width and height
						let minMax: CGSize = bestFitFrame(cardCount: emojiCount, 							  frameSize: geometry.size)
						LazyVGrid(columns: [GridItem(.adaptive(minimum: minMax.height,
															   maximum: minMax.width))]) {
							ForEach(emojis[0..<emojiCount], id: \.self ) { emoji in
								CardView(content: emoji).aspectRatio(2.0/3.0, contentMode: .fit)
							}
						}
					}
				.foregroundColor(.red)
				Spacer()
				}
				.padding(.vertical)
				HStack {
					removeCard
					Spacer()
					travelButton
					Spacer()
					foodButton
					Spacer()
					mathButton
					Spacer()
					addCard
				}
				.font(.largeTitle)
				.padding(.vertical)

		}
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
	var travelButton: some View {
		// when tapped, display the Travel Theme
		Button {
			emojis =  travelEmojis.shuffled()
				// Extra Credit # 1 - make a random number of cards
				// appear each time a theme button is chosen
			emojiCount = Int.random(in: initialCount...emojis.count)
		} label: {
			VStack {
				Image(systemName: "airplane.departure")
				Text("Travel")
					.font(.body)
			}
		}
	}
	var foodButton: some View {
		// when tapped, display the Food Theme
		Button {
			emojis = foodEmojis.shuffled()
				// Extra Credit # 1 - make a random number of cards
				// appear each time a theme button is chosen
			emojiCount = Int.random(in: initialCount...emojis.count)
		} label: {
			VStack {
				Image(systemName: "cart")
				Text("Food")
					.font(.body)
			}
		}
	}
	var mathButton: some View {
		// when tapped, display the Math Theme
			Button {
				emojis = mathEmojis.shuffled()
					// Extra Credit # 1 - make a random number of cards
					// appear each time a theme button is chosen
				emojiCount = Int.random(in: initialCount...emojis.count)
			} label: {
				VStack {
					Image(systemName: "function")
					Text("Math")
						.font(.body)
				}
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

// Extra Credit # 2
/*
	this does not look like the best solution and there still a lot to learn
*/
func bestFitFrame(cardCount: Int, frameSize: CGSize) -> CGSize {
	/*
		using the CGSize(width:, height:) return type as a convient tuple
		the width is the min value and height is the max value
		returned to the LazyVGrid
	*/
	var scaleFactor = CGSize(width: 0, height: 0)
	var returnValue = CGSize(width: 0, height: 0)
	switch cardCount {
		case 21..<25:
			scaleFactor.width = 4600.0
			scaleFactor.height = 4100.0
		case 17..<21:
			scaleFactor.width = 4150.0
			scaleFactor.height = 3470.0
		case 13..<17:
			scaleFactor.width = 3470.0
			scaleFactor.height = 3000.0
		case 09..<13:
			scaleFactor.width = 3300.0
			scaleFactor.height = 3000.0
		case 07..<09:
			scaleFactor.width = 2650.0
			scaleFactor.height = 2300.0
		case 03..<07:
			scaleFactor.width = 2450.0
			scaleFactor.height = 2000.0
		case 01..<03:
			scaleFactor.width = 2200.0
			scaleFactor.height = 2000.0
		default:
			scaleFactor.width = 4500.0
			scaleFactor.height = 4000.0
	}

	returnValue.width = (frameSize.height * frameSize.width) /	(scaleFactor.width )

	print("width: (\(frameSize.height) times \(frameSize.width)) divided by \(scaleFactor.width)) = \(returnValue.width) for \(cardCount) cards")

	returnValue.height = (frameSize.height * frameSize.width) /	(scaleFactor.height )

	print("height: (\(frameSize.height) times \(frameSize.width)) divided by (\(scaleFactor.height)) = \(returnValue.height)")

	return returnValue
}

//struct OuterView: View {
//	var body: some View {
//		VStack {
//			Text("Top")
//			InnerView()
//				.background(.green)
//			Text("Bottom")
//		}
//	}
//}

//struct InnerView: View {
//	var body: some View {
//		HStack {
//			Text("Left")
//			GeometryReader { geo in
//				Text("Center")
//					.background(.blue)
//					.onTapGesture {
//						print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
//						print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
//						print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
//					}
//			}
//			.background(.orange)
//			Text("Right")
//		}
//	}
//}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
		ContentView()
			.preferredColorScheme(.light)
//		OuterView()
//			.preferredColorScheme(.light)
	}
}
