//
//  Pie.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/14/24.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
	var startAngle: Angle = .zero
	let endAngel: Angle
	var clockwise = true

	func path(in rect: CGRect) -> Path {
		let startAngle = startAngle - .degrees(Constants.offsetAngle)
		let endAngle = endAngel - .degrees(Constants.offsetAngle)

		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2
		let start = CGPoint(x: center.x + radius * cos(startAngle.radians),
							y: center.y + radius * sin(endAngle.radians))

		var p = Path()
		p.move(to: center)
		p.addLine(to: start)
		p.addArc(center: center,
				 radius: radius,
				 startAngle: startAngle,
				 endAngle: endAngel,
				 clockwise: !clockwise)
		p.addLine(to: center)
		return p
	}

	private struct Constants {
		static let offsetAngle: Double = 90
	}
}
