# Memorize

A card matching memory game built with SwiftUI that features themed emoji pairs, score tracking, and speech synthesis.

## Features

- 🎴 **Memory Card Game**: Match pairs of emoji cards to win
- 🎨 **Multiple Themes**: Play with different emoji themes (letters, and more)
- 🔊 **Voice Feedback**: Cards speak their emoji content when flipped
- 📊 **Score Tracking**: Keep track of your score as you play
- 🔀 **Shuffle Function**: Shuffle the cards during gameplay
- 🎯 **Game Completion Detection**: Knows when you've matched all pairs

## Architecture

This project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: `MemoryGame.swift` - Core game logic
- **ViewModel**: `EmojiMemoryGame.swift` - Bridges the model and view
- **View**: `EmojiMemoryGameView.swift` - SwiftUI interface

### Key Components

- **Custom Views**: 
  - `Cardify` - Card flip animation modifier
  - `AspectVGrid` - Adaptive grid layout for cards
  - `Pie` - Progress/timer visualization
  - `PoppyIconView` - Custom icon component
  - `ButtonsView` - Game control buttons

- **Design**: 
  - `CardBackDesignOptions` - Customizable card back designs

## Requirements

- iOS 15.0+ / iPadOS 15.0+ / macOS 12.0+
- Xcode 13.0+
- Swift 5.5+

## Getting Started

1. Clone this repository
2. Open the `.xcodeproj` file in Xcode
3. Build and run the project on your device or simulator

## How to Play

1. Tap any card to flip it over
2. Tap a second card to try to find a match
3. If the cards match, they stay face up
4. If they don't match, they flip back over
5. Try to match all pairs with the highest score possible!
6. Use the shuffle button to rearrange cards on the board
7. Start a new game anytime with the new game button

## Project Structure

```
Memorize/
├── MemorizeApp.swift           # App entry point
├── Model/
│   └── MemoryGame.swift        # Core game logic
├── ViewModel/
│   └── EmojiMemoryGame.swift   # View model with game state
├── Views/
│   ├── EmojiMemoryGameView.swift
│   ├── ButtonsView.swift
│   ├── AspectVGrid.swift
│   └── PoppyIconView.swift
└── Utilities/
    ├── Cardify.swift
    ├── Pie.swift
    └── CardBackDesignOptions.swift
```

## Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **Swift Concurrency**: Async/await patterns
- **AVFoundation**: Speech synthesis for card content
- **Combine**: Reactive state management with `@Published` properties

## License

This project is available for educational and personal use.

## Acknowledgments

Created by Chip O'Connor

---

Enjoy playing Memorize! 🎮
