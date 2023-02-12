//
//  CountModel.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import Foundation

struct CountModel: Identifiable, Codable, Hashable {
    let id: UUID

    var loopSize: Int {
        _loopSize
    }
    var total: Int {
        _total
    }
    var value: Int {
        _total - loops * loopSize
    }
    var loops: Int {
        total / loopSize
    }

    private var _loopSize: Int
    private var _total: Int
    private let defaultLoopSize: Int

    init(loopSize: Int) {
        guard loopSize > 1 else { fatalError("Incorrect loop size") }
        id = UUID()
        defaultLoopSize = loopSize
        _loopSize = loopSize
        _total = 0
    }

    mutating func increment() {
        _total += 1
    }

    mutating func decrement() {
        guard _total > 0 else { return }
        _total -= 1
    }

    mutating func reset() {
        _total = loops * loopSize
    }

    mutating func hardReset() {
        _total = 0
    }

    mutating func setLoopSize(_ newLoopSize: Int) {
        guard newLoopSize > 1 else {
            Log.error("Incorrect new loop size")
            return
        }
        _loopSize = newLoopSize
    }

    mutating func setDefaultLoopSize() {
        _loopSize = defaultLoopSize
    }
}
