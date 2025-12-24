//
//  Speaker.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/17/24.
//

import AVFoundation


class Speaker: NSObject, AVSpeechSynthesizerDelegate {
	var synthesizer = AVSpeechSynthesizer()
	var startLanguage = "en-US"

	override init() {
		super.init()
		synthesizer.delegate = self
	}

	func speak(_ msg: String) {
		// For letter themes like "A a", speak only the first letter
		// For single emojis or numbers, speak the entire content
		let textToSpeak: String
		
		if msg.contains(" "), let firstWord = msg.split(separator: " ").first {
			// If content has a space (like "A a"), speak only the first part
			textToSpeak = String(firstWord)
		} else {
			// For emojis, numbers, or single words, speak as-is
			textToSpeak = msg
		}
		
		// Use IPA notation for single letters to avoid "Capital A" pronunciation
		let finalText: String
		if textToSpeak.count == 1, let char = textToSpeak.first, char.isLetter {
			// Use IPA phonetic notation to speak just the letter sound
			finalText = getIPAForLetter(char)
		} else {
			finalText = textToSpeak
		}
		
		let utterance = AVSpeechUtterance(string: finalText)
		utterance.rate = 0.4
		utterance.pitchMultiplier = 0.8
		utterance.postUtteranceDelay = 0.2
		utterance.volume = 0.8
		synthesizer.speak(utterance)
	}
	
	// Convert single letters to phonetic spellings to avoid "Capital" prefix
	private func getIPAForLetter(_ letter: Character) -> String {
		let letterMap: [Character: String] = [
			"A": "aye", "B": "bee", "C": "see", "D": "dee", "E": "ee",
			"F": "eff", "G": "jee", "H": "aych", "I": "eye", "J": "jay",
			"K": "kay", "L": "ell", "M": "em", "N": "en", "O": "oh",
			"P": "pee", "Q": "cue", "R": "are", "S": "ess", "T": "tee",
			"U": "you", "V": "vee", "W": "double you", "X": "ex", "Y": "why", "Z": "zee"
		]
		
		let upperLetter = Character(letter.uppercased())
		return letterMap[upperLetter] ?? String(letter)
	}
}
