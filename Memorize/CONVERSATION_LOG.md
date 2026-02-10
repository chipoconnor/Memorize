# Memorize - AI Assistant Conversation Log

Use this file to keep notes between sessions. Paste a summary at the start of each new chat
so the assistant can quickly get back up to speed.

---

## Project Overview

**App Name**: Memorize  
**Created by**: Chip O'Connor  
**Architecture**: MVVM  
**Minimum Target**: iOS 15.0+ / iPadOS 15.0+ / macOS 12.0+

### Key Files
- `MemorizeApp.swift` — App entry point; owns `@StateObject var game = EmojiMemoryGame()` and passes it to the root view
- `MemoryGame.swift` — Model: core game logic, scoring, bonus time
- `EmojiMemoryGame.swift` — ViewModel: manages themes, game state, speech synthesis
- `EmojiMemoryGameView.swift` — Main game view
- `CardView.swift` — Individual card view with flip animation and bonus timer pie
- `ButtonsView.swift` — Shuffle + theme selection buttons
- `PoppyIconView.swift` — Custom SwiftUI-drawn app icon (red poppy flower)
- `Pie.swift` — `Shape` subclass that draws a clock-style arc; used as bonus time indicator on each card; takes `startAngle`, `endAngle`, and `clockwise` params; offsets by 90° so 0 starts at top
- `FlyingNumber.swift` — Animates a score change number flying up (green) or down (red) and fading out; uses `@State var offset`; displays `+` or `-` prefix automatically
- `LoggingSetup.swift` — Stub workaround for a known benign AVFoundation console error ("Missing key for 'primary'"); no actual suppression implemented
- `Cardify.swift` — Card flip animation view modifier (not yet seen by assistant)
- `AspectVGrid.swift` — Adaptive grid layout (not yet seen by assistant)
- `Theme.swift` — Theme definitions with emojis, colors, icons (not yet seen by assistant)
- `Speaker.swift` — AVFoundation-based text-to-speech class (not yet seen by assistant)
- `CardBackDesignOptions.swift` — Card back design customization (not yet seen by assistant)

---

## Known Design Decisions

- `EmojiMemoryGame` uses `@ObservedObject` in the view (not `@StateObject`)
- `gameId: UUID` is used on the cards grid to force view recreation on new game
- Cards speak their emoji content aloud when flipped (via `Speaker` / AVFoundation)
- Bonus time scoring: cards earn more points the faster they are matched
- `isGameComplete` triggers a congratulations alert with score
- Theme buttons shown in `ButtonsView` with opacity to highlight the active theme
- `PoppyIconView` is a fully SwiftUI-drawn app icon — not an image asset

## Partially Implemented / TODO (inferred from code)

- `matchedGeometryEffect` and deck dealing code exists in `EmojiMemoryGameView`
  but the deck UI is not currently wired into the main view body —
  `deck`, `deal()`, `view(for:)`, `dealt`, and `dealingNamespace` appear unused
- `lastScoreChange` and `scoreChange(causedBy:)` are defined in `EmojiMemoryGameView`
  but not yet displayed in UI — `FlyingNumber` exists and is ready to use for this
- The "Change Theme" button in the game-complete alert has no action yet
- `LoggingSetup.swift` has a stub for suppressing a benign AVFoundation console error
  ("Missing key for 'primary'") but no suppression is actually implemented;
  `suppressKnownBenignErrors()` is an empty function

---

## Session Notes

### Session — February 10, 2026
- Reviewed full project codebase for the first time
- User asked about storing conversation history between sessions
- Created this CONVERSATION_LOG.md file
- Noted several partially-implemented features (deck dealing, score change display)

---

## How to Use This File

Before starting a new AI assistant session, paste the contents of this file
into the chat (or just say "here's our history") so the assistant can
pick up where you left off. Update the **Session Notes** section after
each productive conversation.
