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
- `MemoryGame.swift` — Model: core game logic, scoring, bonus time
- `EmojiMemoryGame.swift` — ViewModel: manages themes, game state, speech synthesis
- `EmojiMemoryGameView.swift` — Main game view
- `CardView.swift` — Individual card view with flip animation and bonus timer pie
- `ButtonsView.swift` — **DELETED** February 10, 2026; replaced by inline HStack (Shuffle + Themes) in `EmojiMemoryGameView` and new `ThemePickerView`
- `ThemePickerView.swift` — Half-sheet theme picker; `List` of all themes with icon, name, emoji preview, and checkmark on active theme; opened by Themes button or "Change Theme" alert button
- `PoppyIconView.swift` — Custom SwiftUI-drawn app icon (red poppy flower)
- `Cardify.swift` — Card flip animation view modifier (not yet seen by assistant)
- `AspectVGrid.swift` — Adaptive grid layout (not yet seen by assistant)
- `Pie.swift` — Bonus time arc indicator (not yet seen by assistant)
- `Theme.swift` — `struct Theme: Identifiable, Equatable`; properties: `id` (= `name`), `name`, `emojis: [String]`, `numberOfPairs: Int`, `color: Color`, `icon: String`; `numberOfPairs` defaults to `min(emojis.count, 8)`; four static themes: `.transport` (blue, 14 emojis), `.letters` (green, 26 emojis), `.numbers` (orange, 11 emojis), `.food` (red, 14 emojis); `allThemes = [transport, letters, numbers, food]`; ⚠️ Transport has duplicate "🚁"; Numbers has commented-out larger values
- `Speaker.swift` — AVFoundation-based text-to-speech class (not yet seen by assistant)

---

## Known Design Decisions

- `EmojiMemoryGame` uses `@ObservedObject` in the view (not `@StateObject`)
- `gameId: UUID` is used on the cards grid to force view recreation on new game
- Cards speak their emoji content aloud when flipped (via `Speaker` / AVFoundation)
- Bonus time scoring: cards earn more points the faster they are matched
- `isGameComplete` triggers a congratulations alert with score
- Theme buttons shown in `ThemePickerView` (half-sheet) with checkmark on active theme
- `PoppyIconView` is a fully SwiftUI-drawn app icon — not an image asset

## Partially Implemented / TODO (inferred from code)

- `matchedGeometryEffect` and deck dealing code exists in `EmojiMemoryGameView`
  but the deck UI is not currently wired into the main view body —
  `deck`, `deal()`, `view(for:)`, `dealt`, and `dealingNamespace` appear unused
- `lastScoreChange` and `scoreChange(causedBy:)` are defined but not yet displayed in UI
- The "Change Theme" alert action now opens `ThemePickerView` sheet ✅ (was empty)
- `theme.emojis` confirmed as `[String]`

### Session — February 10, 2026 (continued)
- Refactored `EmojiMemoryGameView`: replaced `ButtonsView` with inline Shuffle + Themes buttons
- Created `ThemePickerView.swift` — half-sheet with `List` of themes, emoji preview, checkmark on active
- Wired "Change Theme" alert button to open `ThemePickerView`
- Deleted `ButtonsView.swift` (now unused)
- Confirmed `theme.emojis` is `[String]`

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
