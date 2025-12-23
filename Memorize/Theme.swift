//
//  Theme.swift
//  Memorize
//
//  Created by Chip O'Connor on 12/22/24.
//

import SwiftUI

struct Theme: Identifiable, Equatable {
    let id: String
    let name: String
    let emojis: [String]
    let numberOfPairs: Int
    let color: Color
    let icon: String
    
    init(name: String, emojis: [String], numberOfPairs: Int? = nil, color: Color, icon: String) {
        self.id = name
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs ?? min(emojis.count, 8)
        self.color = color
        self.icon = icon
    }
    
    static let transport = Theme(
        name: "Transport",
        emojis: ["🚌", "🛻", "🚗", "🚀", "🚁", "🚂", "⛵️", "🛵", "🏎️", "🛰️", "✈️", "🚲", "🛴", "🚁"],
        color: .blue,
        icon: "airplane.departure"
    )
    
    static let letters = Theme(
        name: "Letters",
        emojis: ["A a", "B b", "C c", "D d", "E e", "F f", "G g", "H h", "I i", "J j",
                 "K k", "L l", "M m", "N n", "O o", "P p", "Q q", "R r", "S s", "T t",
                 "U u", "V v", "W w", "X x", "Y y", "Z z"],
        color: .green,
        icon: "a.square"
    )
    
    static let numbers = Theme(
        name: "Numbers",
        emojis: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                 "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"],
        color: .orange,
        icon: "123.rectangle"
    )
    
    static let food = Theme(
        name: "Food",
        emojis: ["🥕", "🍏", "🥔", "🍌", "🥑", "🥨", "🍕", "🫔", "🌮", "🥭", "🍎", "🍇", "🍓", "🥦"],
        color: .red,
        icon: "fork.knife"
    )
    
    static let allThemes = [transport, letters, numbers, food]
}
