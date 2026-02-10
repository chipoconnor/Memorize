//
//  LoggingSetup.swift
//  Memorize
//
//  Created by Chip O'Connor on 12/22/24.
//

import Foundation
import os.log

	/// Suppresses specific known benign errors from appearing in the debug console.
	///
	/// ## Background
	/// AVFoundation emits a harmless "Missing key for 'primary'" message to stderr
	/// during speech synthesis initialisation. This is a known Apple framework bug
	/// with no user-facing impact.
	///
	/// ## Why this function is intentionally empty
	/// There is no public, supported Apple API that allows filtering console output
	/// by message content. The two realistic alternatives are:
	///
	/// 1. **Redirect `stderr` to `/dev/null`** — silences *all* stderr output,
	///    which would hide genuine errors during development.
	///
	/// 2. **Intercept `stderr` with a pipe and filter by string** — involves
	///    low-level `dup2`/`pipe` C calls, is fragile (Apple can change the message
	///    wording at any time), and carries risk of masking real errors in production.
	///    It is not recommended for App Store releases.
	///
	/// The safest and most maintainable approach is to leave this function empty
	/// and accept the console noise. The message is visible only to developers
	/// in the Xcode debug console and is never shown to users.
	///
	/// ## If Apple fixes this
	/// If a future OS update stops emitting the message, this function and its
	/// call site in `MemorizeApp.init()` can simply be deleted.
	///
	/// ## References
	/// - FB12345678 — Apple Feedback Assistant report (replace with actual ID if filed)
	/// - Known to affect AVSpeechSynthesizer on iOS 16+
	/// 
func suppressKnownBenignErrors() {
	// Intentionally empty. See documentation above.

	// Note: This is a workaround for an Apple bug in AVFoundation
	// The error about "Missing key for 'primary'" is harmless but annoying
	// Unfortunately, there's no direct way to suppress it without filtering all logs
}
