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
		
		let utterance = AVSpeechUtterance(string: textToSpeak)
		utterance.rate = 0.4
		utterance.pitchMultiplier = 0.8
		utterance.postUtteranceDelay = 0.2
		utterance.volume = 0.8
		synthesizer.speak(utterance)
	}
}
