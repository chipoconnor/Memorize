//
//  LoggingSetup.swift
//  Memorize
//
//  Created by Chip O'Connor on 12/22/24.
//

import Foundation
import os.log

/// Suppresses specific known benign errors from appearing in console
func suppressKnownBenignErrors() {
	// Note: This is a workaround for an Apple bug in AVFoundation
	// The error about "Missing key for 'primary'" is harmless but annoying
	// Unfortunately, there's no direct way to suppress it without filtering all logs
}
