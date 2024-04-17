//
//  Speaker.swift
//  Memorize
//
//  Created by Chip O'Connor on 4/17/24.
//

import AVFoundation


class Speaker: NSObject, AVSpeechSynthesizerDelegate {
	let synthesizer = AVSpeechSynthesizer()

	override init() {
		super.init()
		synthesizer.delegate = self
	}

	func speak(_ msg: String) {
		let utterance = AVSpeechUtterance(string: msg.lowercased())

		utterance.rate = 0.5
		utterance.pitchMultiplier = 0.8
		utterance.postUtteranceDelay = 0.2
		utterance.volume = 0.8
		utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
		synthesizer.speak(utterance)
	}
}
