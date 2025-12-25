//
//  PoppyIconView.swift
//  Memorize
//
//  Red poppy flower design for app icon
//

import SwiftUI

struct PoppyIconView: View {
	var body: some View {
		ZStack {
			// Background
			Color.white
			
			// Poppy flower
			PoppyFlower()
				.frame(width: 300, height: 300)
		}
		.frame(width: 1024, height: 1024)
	}
}

struct PoppyFlower: View {
	var body: some View {
		ZStack {
			// Back petals (slightly darker, rotated)
			ForEach(0..<4) { index in
				Petal()
					.fill(
						RadialGradient(
							colors: [
								Color(red: 0.85, green: 0.15, blue: 0.15),
								Color(red: 0.7, green: 0.1, blue: 0.1)
							],
							center: .center,
							startRadius: 20,
							endRadius: 120
						)
					)
					.frame(width: 140, height: 160)
					.rotationEffect(.degrees(Double(index) * 90 + 45))
					.offset(y: -15)
			}
			
			// Front petals (brighter red)
			ForEach(0..<4) { index in
				Petal()
					.fill(
						RadialGradient(
							colors: [
								Color(red: 0.95, green: 0.25, blue: 0.2),
								Color(red: 0.85, green: 0.15, blue: 0.15)
							],
							center: .center,
							startRadius: 20,
							endRadius: 120
						)
					)
					.frame(width: 140, height: 160)
					.rotationEffect(.degrees(Double(index) * 90))
					.offset(y: -15)
			}
			
			// Center of flower (dark with stamens)
			ZStack {
				// Outer center ring
				Circle()
					.fill(
						RadialGradient(
							colors: [
								Color(red: 0.2, green: 0.1, blue: 0.15),
								Color(red: 0.1, green: 0.05, blue: 0.1)
							],
							center: .center,
							startRadius: 0,
							endRadius: 40
						)
					)
					.frame(width: 50, height: 50)

				// Stamens pattern
				ForEach(0..<12) { index in
					Capsule()
						.fill(Color(red: 0.3, green: 0.25, blue: 0.2))
						.frame(width: 3, height: 15)
						.offset(y: -20)
						.rotationEffect(.degrees(Double(index) * 30))
				}
				
				// Center dot
				Circle()
					.fill(Color(red: 0.15, green: 0.1, blue: 0.12))
					.frame(width: 20, height: 20)
			}
		}
	}
}

// Custom petal shape
struct Petal: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		let width = rect.width
		let height = rect.height
		
		// Start at bottom center
		path.move(to: CGPoint(x: width / 2, y: height))
		
		// Left side curve
		path.addQuadCurve(
			to: CGPoint(x: width / 2, y: 0),
			control: CGPoint(x: width * 0.1, y: height * 0.4)
		)
		
		// Right side curve
		path.addQuadCurve(
			to: CGPoint(x: width / 2, y: height),
			control: CGPoint(x: width * 0.9, y: height * 0.4)
		)
		
		path.closeSubpath()
		return path
	}
}

// Preview for testing
#Preview("Poppy Icon") {
	PoppyIconView()
}

#Preview("Poppy Flower Only") {
	PoppyFlower()
		.frame(width: 300, height: 300)
		.background(Color.white)
}

// MARK: - Usage Instructions
/*
 To create your app icon:
 
 1. Run the app and view the "Poppy Icon" preview in Xcode
 2. Take a screenshot of the preview (Cmd+Shift+4 on Mac)
 3. Crop the image to exactly 1024x1024 pixels if needed
 4. Save as PNG with the name "AppIcon.png"
 5. In Xcode:
    - Open Assets.xcassets
    - Find AppIcon
    - Drag your 1024x1024 image into the 1024pt slot
 
 Alternatively, you can customize the colors and design:
 - Adjust the gradient colors for different red shades
 - Change the number of petals (change ForEach ranges)
 - Modify petal shape in the Petal struct
 - Add more detail to the center (stamens, texture, etc.)
*/
