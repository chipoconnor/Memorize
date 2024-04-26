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
		let utterance = AVSpeechUtterance(string: msg.last!.lowercased())
		utterance.rate = 0.4
		utterance.pitchMultiplier = 0.8
		utterance.postUtteranceDelay = 0.2
		utterance.volume = 0.8
//		let voices = AVSpeechSynthesisVoice.speechVoices()
//		for voice in voices {
//			print(voice)
//			if voice.language == currentLanguageCode() && voice.name == "Samantha" {
//				utterance.voice = voice
//				utterance.voice = AVSpeechSynthesisVoice(language: voice.language,
//														 Namespace: voice.name)
//				//break
//			}
//		}
		synthesizer.speak(utterance)
	}
}
