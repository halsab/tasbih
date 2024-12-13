//
//  AppStateModel.swift
//  tasbih
//
//  Created by Khalil Sabirov on 02.07.2024.
//

import Foundation
import SwiftData

@Model
final class AppStateModel {
    var count: CountModel

    init(count: CountModel) {
        self.count = count
    }
}
