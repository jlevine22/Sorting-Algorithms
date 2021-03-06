//
//  Task+Sleep.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
    
    static func defaultPause() async throws {
        try await sleep(seconds: 0.1)
    }
}
