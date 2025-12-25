//
//  CardBackDesignOptions.swift
//  Memorize
//
//  Alternative card back designs for inspiration
//

import SwiftUI

// MARK: - Option 1: Diamond Pattern
extension Cardify {
	var diamondPattern: some View {
		GeometryReader { geometry in
			ZStack {
				// Base gradient
				LinearGradient(
					colors: [
						Color.white.opacity(0.4),
						Color.white.opacity(0.2)
					],
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
				
				// Diamond pattern
				if let icon = themeIcon {
					LazyVGrid(columns: [
						GridItem(.flexible()),
						GridItem(.flexible()),
						GridItem(.flexible())
					], spacing: geometry.size.height / 6) {
						ForEach(0..<9, id: \.self) { _ in
							Image(systemName: icon)
								.font(.system(size: geometry.size.width / 8))
								.foregroundColor(.black.opacity(0.5))
//								.rotationEffect(.degrees(45))
						}
					}
					.padding()
				}
			}
		}
	}
}

// MARK: - Option 2: Spiral Pattern
extension Cardify {
	var spiralPattern: some View {
		GeometryReader { geometry in
			ZStack {
				// Radial gradient
				RadialGradient(
					colors: [
						Color.white.opacity(0.5),
						Color.white.opacity(0.1)
					],
					center: .center,
					startRadius: 0,
					endRadius: geometry.size.width
				)
				
				// Circular icon arrangement
				if let icon = themeIcon {
					ForEach(0..<8, id: \.self) { index in
						Image(systemName: icon)
							.font(.system(size: 15))
							.foregroundColor(.black.opacity(0.5))
							.offset(x: cos(Double(index) * .pi / 4) * 30,
									y: sin(Double(index) * .pi / 4) * 30)
					}
					
					// Center icon
					Image(systemName: icon)
						.font(.system(size: 25))
						.foregroundColor(.black.opacity(0.5))
				}
			}
		}
	}
}

// MARK: - Option 3: Stripes with Icon
extension Cardify {
	var stripedPattern: some View {
		GeometryReader { geometry in
			ZStack {
				// Diagonal stripes
				ForEach(0..<15, id: \.self) { index in
					Rectangle()
						.fill(Color.white.opacity(index % 2 == 0 ? 0.1 : 0.2))
						.frame(height: 10)
						.offset(x: CGFloat(index) * 15 - geometry.size.width / 2)
						.rotationEffect(.degrees(45))
				}
				
				// Centered icon with glow effect
				if let icon = themeIcon {
					Image(systemName: icon)
						.font(.system(size: 40, weight: .thin))
						.foregroundColor(.white)
						.opacity(0.3)
						.shadow(color: .black.opacity(0.5), radius: 10)
				}
			}
			.clipped()
		}
	}
}

// MARK: - Option 4: Corner Icons with Border
extension Cardify {
	var cornerIconsPattern: some View {
		ZStack {
			// Subtle gradient
			LinearGradient(
				colors: [
					Color.white.opacity(0.3),
					Color.white.opacity(0.15),
					Color.white.opacity(0.3)
				],
				startPoint: .top,
				endPoint: .bottom
			)
			
			// Double border
			RoundedRectangle(cornerRadius: Constants.cornerRadius - 2)
				.strokeBorder(Color.white.opacity(0.6), lineWidth: 1)
				.padding(4)
			
			RoundedRectangle(cornerRadius: Constants.cornerRadius - 4)
				.strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
				.padding(8)
			
			// Corner icons
			if let icon = themeIcon {
				VStack {
					HStack {
						Image(systemName: icon)
							.font(.system(size: 20))
						Spacer()
						Image(systemName: icon)
							.font(.system(size: 20))
					}
					Spacer()
					HStack {
						Image(systemName: icon)
							.font(.system(size: 20))
						Spacer()
						Image(systemName: icon)
							.font(.system(size: 20))
					}
				}
				.foregroundColor(.black.opacity(0.5))
				.padding()
			}
		}
	}
}

// MARK: - Option 5: Animated Shimmer Effect
extension Cardify {
	var shimmerPattern: some View {
		GeometryReader { geometry in
			ZStack {
				// Base color
				Color.white.opacity(0.2)
				
				// Shimmer effect (would need animation state)
				LinearGradient(
					colors: [
						Color.white.opacity(0.0),
						Color.white.opacity(0.3),
						Color.white.opacity(0.0)
					],
					startPoint: .leading,
					endPoint: .trailing
				)
				
				// Large centered icon
				if let icon = themeIcon {
					Image(systemName: icon)
						.font(.system(size: 50, weight: .ultraLight))
						.foregroundColor(.black)
						.opacity(0.5)
				}
			}
		}
	}
}

// MARK: - Usage Instructions
/*
 To use any of these patterns, replace the `cardBackDesign` computed property
 in the main Cardify struct with one of these options:
 
 Example:
 @ViewBuilder
 private var cardBackDesign: some View {
	 cornerIconsPattern  // or diamondPattern, spiralPattern, etc.
 }
 
 You can also make this customizable by adding an enum to Theme:
 
 enum CardBackStyle {
	 case grid, diamond, spiral, striped, corners, shimmer
 }
 
 Then pass the style through from your Theme and switch between patterns.
*/
